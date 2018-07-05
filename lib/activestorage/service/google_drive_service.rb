# frozen_string_literal: true
require 'google/apis/drive_v2'

module ActiveStorage
  class Service::GoogleDriveService < Service

    # Upload the +io+ to the +key+ specified. If a +checksum+ is provided, the service will
    # ensure a match when the upload has completed or raise an ActiveStorage::IntegrityError.
    def upload(key, io, checksum: nil)
      raise NotImplementedError
    end

    # Return the content of the file at the +key+.
    def download(key)
      raise NotImplementedError
    end

    # Return the partial content in the byte +range+ of the file at the +key+.
    def download_chunk(key, range)
      raise NotImplementedError
    end

    # Delete the file at the +key+.
    def delete(key)
      raise NotImplementedError
    end

    # Delete files at keys starting with the +prefix+.
    def delete_prefixed(prefix)
      raise NotImplementedError
    end

    # Return +true+ if a file exists at the +key+.
    def exist?(key)
      raise NotImplementedError
    end

    # Returns a signed, temporary URL for the file at the +key+. The URL will be valid for the amount
    # of seconds specified in +expires_in+. You must also provide the +disposition+ (+:inline+ or +:attachment+),
    # +filename+, and +content_type+ that you wish the file to be served with on request.
    def url(key, expires_in:, disposition:, filename:, content_type:)
      raise NotImplementedError
    end

    # Returns a signed, temporary URL that a direct upload file can be PUT to on the +key+.
    # The URL will be valid for the amount of seconds specified in +expires_in+.
    # You must also provide the +content_type+, +content_length+, and +checksum+ of the file
    # that will be uploaded. All these attributes will be validated by the service upon upload.
    def url_for_direct_upload(key, expires_in:, content_type:, content_length:, checksum:)
      raise NotImplementedError
    end

    # Returns a Hash of headers for +url_for_direct_upload+ requests.
    def headers_for_direct_upload(key, filename:, content_type:, content_length:, checksum:)
      {}
    end

    private

    def client
      @client ||= begin
        client = Google::Apis::DriveV3::DriveService.new
        client.authorization = authorizer
        client
      end
    end

    def authorizer
       @authorizer ||= Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open(config[:credentials]),
          scope: 'https://www.googleapis.com/auth/drive'
       )
    end
  end
end
