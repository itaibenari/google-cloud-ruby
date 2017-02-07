# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Cloud
    module Debugger
      class Breakpoint
        class Variable
          attr_accessor :name

          attr_accessor :value

          attr_accessor :type

          attr_accessor :members

          def initialize
            @name = nil
            @value =nil
            @type = nil
            @members = []
          end

          def self.from_rb_var source
            Variable.new.tap do |var|
              var.type = source.class.to_s
              var.value = source.to_s
              # TODO: recursively add members variable array
            end
          end

          def to_grpc
            Google::Apis::ClouddebuggerV2::Variable.new.tap do |v|
              v.name = @name
              v.value = @value
              v.type = @type
              v.members = @members.map { |mem| mem.to_grpc }
            end
          end
        end
      end
    end
  end
end