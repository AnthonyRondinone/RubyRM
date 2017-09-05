require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'


class SQLObject
  def self.columns
    table = self.table_name
    @columns ||= DBConnection.execute2(<<-SQL)
    SELECT
    *
    FROM
    #{table}
    SQL
    @columns.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
        define_method(col) do
          self.attributes[col]
        end
        define_method("#{col}=") do |value|
          self.attributes[col] = value
        end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
    SELECT #{self.table_name}.*
    FROM #{self.table_name}
    SQL
    self.parse_all(all)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end

  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
    SELECT #{self.table_name}.*
    FROM #{self.table_name}
    WHERE id = #{id}
    SQL
    return nil if result.empty?
    self.new(result.first)
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      if !self.class.columns.include?(attr_name.to_sym)
        raise("unknown attribute '#{attr_name}'")
      else
        self.send("#{attr_name}=", val)
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
   self.class.columns.map { |attr| self.send(attr) }
 end

  def insert

    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns
   .map { |attr| "#{attr} = ?" }.join(", ")

   DBConnection.execute(<<-SQL, *attribute_values, id)
   UPDATE
     #{self.class.table_name}
   SET
     #{set_line}
   WHERE
     #{self.class.table_name}.id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end

end
