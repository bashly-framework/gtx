module MockContext
  class One
    def get_binding
      binding
    end
  end

  class Two
    def report
      'success'
    end
  end
end
