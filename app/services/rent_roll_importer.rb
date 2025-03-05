class RentRollImporter
  def self.import(file_path)
    if file_path.nil? || file_path.empty? || !File.exist?(file_path)
      puts "Please provide a valid CSV file path."
      return false
    end

    begin
      RentRollProcessor.process(file_path)
      puts "Import succeeded."
      true
    rescue StandardError => e
      puts "Import failed: #{e.message}"
      false
    end
  end
end
