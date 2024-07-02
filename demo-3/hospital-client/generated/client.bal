// Copyright (c) 2024 Gayal Dassanayake

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
// permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
// Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config =  {}, string serviceUrl = "http://localhost:9090/hospital") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Delete a patient by ID
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function delete patients/[string patientId](map<string|string[]> headers = {}) returns Patient|error {
        string resourcePath = string `/patients/${getEncodedUri(patientId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Delete a record by ID
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function delete records/[string recordId](map<string|string[]> headers = {}) returns MedicalRecord|error {
        string resourcePath = string `/records/${getEncodedUri(recordId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Get a list of patients
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function get patients(map<string|string[]> headers = {}) returns Patient[]|error {
        string resourcePath = string `/patients`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a patient by ID
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function get patients/[string patientId](map<string|string[]> headers = {}) returns Patient|error {
        string resourcePath = string `/patients/${getEncodedUri(patientId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a list of medical records
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function get records(map<string|string[]> headers = {}) returns MedicalRecord[]|error {
        string resourcePath = string `/records`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get a medical record by ID
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function get records/[string recordId](map<string|string[]> headers = {}) returns MedicalRecord|error {
        string resourcePath = string `/records/${getEncodedUri(recordId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Get medical records for a Patient ID
    #
    # + headers - Headers to be sent with the request 
    # + return - Ok 
    resource isolated function get recordsByPatient/[string patientId](map<string|string[]> headers = {}) returns MedicalRecord[]|error {
        string resourcePath = string `/recordsByPatient/${getEncodedUri(patientId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Create a new patient
    #
    # + headers - Headers to be sent with the request 
    # + payload - PatientEntry object to be created  
    # + return - Created 
    resource isolated function post patients(PatientEntry payload, map<string|string[]> headers = {}) returns Patient|error {
        string resourcePath = string `/patients`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Create a new medical record
    #
    # + headers - Headers to be sent with the request 
    # + payload - MedicalRecord object to be created  
    # + return - Created 
    resource isolated function post records(MedicalRecordEntry payload, map<string|string[]> headers = {}) returns MedicalRecord|error {
        string resourcePath = string `/records`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update a patient by ID
    #
    # + headers - Headers to be sent with the request 
    # + payload - Patient object to be updated  
    # + return - Ok 
    resource isolated function put patients/[string patientId](PatientEntry payload, map<string|string[]> headers = {}) returns Patient|error {
        string resourcePath = string `/patients/${getEncodedUri(patientId)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }

    # Update a recoed by ID
    #
    # + headers - Headers to be sent with the request 
    # + payload - Medical record object to be updated  
    # + return - Ok 
    resource isolated function put records/[string recordId](MedicalRecordEntry payload, map<string|string[]> headers = {}) returns MedicalRecord|error {
        string resourcePath = string `/records/${getEncodedUri(recordId)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }
}
