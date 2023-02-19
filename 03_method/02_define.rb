# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method '//' do
    '//'
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
# - また、2で定義するメソッドは以下を満たすものとする
#   - メソッドが定義されるのは同時に生成されるオブジェクトのみで、別のA2インスタンスには（同じ値を含む配列を生成時に渡さない限り）定義されない
class A2
  def initialize(array)
    # オブジェクトの特異クラスにメソッドを定義する
    array.each do |val|
      val_with_prefix = "hoge_#{val}"
      define_singleton_method val_with_prefix.to_sym do |num|
        return dev_team if num.nil?

        val_with_prefix * num
      end
    end
  end

  def dev_team
    "SmartHR Dev Team"
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def my_attr_accessor(name)
      define_method name do
        @original_accessor_hash&.[](name)
      end

      define_method "#{name}=" do |val|
        @original_accessor_hash ||= {}
        @original_accessor_hash[name] = val

        if val.is_a?(TrueClass) || val.is_a?(FalseClass)
          self.define_singleton_method "#{name}?" do
            @original_accessor_hash&.[](name)
          end
        end
      end
    end
  end
end
