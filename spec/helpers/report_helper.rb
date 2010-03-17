module ReportHelper
    def stub_report(options={})
        report = Puppet::Transaction::Report.new
        report.stubs options
        report
    end
end
