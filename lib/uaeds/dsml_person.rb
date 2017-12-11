module Uaeds
  class DSMLPerson < DSML
    def date_of_birth
      if(@value_h.key? :dateOfBirth)
        @value_h[:dateOfBirth]
      else
        dob = get_value(:dateOfBirth)
        if dob.nil? || (dob.length == 0)
          @value_h[:dateOfBirth] = nil
        else
          dob = Date.new(dob[0,4], dob[4,2], dob[6,2])
          @value_h[:dateOfBirth] = dob
        end
        @value_h[:dateOfBirth]
      end
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

    def surname
      preferred_name = lookup_value(:preferredSn)
      if preferred_name
        preferred_name
      else
        lookup_value(:sn)
      end
    end

    def given_name
      preferred_name = lookup_value(:preferredGivenname)
      if preferred_name
        preferred_name
      else
        lookup_value(:givenName)
      end
    end

    def first_name
      given_name
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

    def email
      mail
    end

    def mail
      lookup_value(:mail)
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

  end

end
