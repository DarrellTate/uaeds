module Uaeds
  class JSONPerson < DSML
    def initialize(hash=nil)
      raise ArgumentError, 'Argument is not a hash' unless (hash && hash.is_a?(Hash))
      @value_h = hash
    end

    def date_of_birth
      lookup_value(:dateOfBirth)
    end

    def dob
      date_of_birth
    end

    def netid
      uid
    end

    def uid
      lookup_value(:uid)
    end

    def uaid
      lookup_value(:uaId)
    end

    def cat_card
      iso_number
    end

    def iso_number
      lookup_value(:isoNumber)
    end

    def employee_id
      emplid
    end

    def emplid
      lookup_value(:emplId)
    end

    def name
      cn
    end

    def full_name
      cn
    end

    def cn
      lookup_value(:cn)
    end

    def person_type
      edu_person_primary_affiliation
    end

    def edu_person_primary_affiliation
      lookup_value(:eduPersonPrimaryAffiliation)
    end

    def title
      employee_title
    end

    def employee_title
      lookup_value(:employeeTitle)
    end

    def department
      employee_primary_dept
    end

    def employee_primary_dept
      lookup_value(:employeePrimaryDept)
    end

    def department_name
      employee_primary_dept_name
    end

    def employee_primary_dept_name
      lookup_value(:employeePrimaryDeptName)
    end

    def lookup_value(val)
      k = val.to_s.downcase
      if(@value_h.key? k)
        @value_h[k]
      else
        nil
      end
    end
  end

end
