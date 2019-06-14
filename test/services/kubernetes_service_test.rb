# frozen_string_literal: true

require 'test_helper'
require 'base64'

class Integration::KubernetesServiceTest < ActiveSupport::TestCase
  include Base64

  def before_setup
    @_env = ENV.to_hash
    super
  end

  def after_teardown
    ENV.replace(@_env)
  end

  test 'create ingress ' do
    ENV['KUBERNETES_NAMESPACE'] = 'zync'
    ENV['KUBE_TOKEN'] = strict_encode64('token')
    ENV['KUBE_SERVER'] = 'http://localhost'
    ENV['KUBE_CA'] = encode64 <<~CERTIFICATE
      -----BEGIN CERTIFICATE-----
      MIIBZjCCAQ2gAwIBAgIQBHMSmrmlj2QTqgFRa+HP3DAKBggqhkjOPQQDAjASMRAw
      DgYDVQQDEwdyb290LWNhMB4XDTE5MDQwNDExMzI1OVoXDTI5MDQwMTExMzI1OVow
      EjEQMA4GA1UEAxMHcm9vdC1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABGG2
      NDgiBuXNVWVVxrDNVjPsKm14wg76w4830Zn3K24u03LJthzsB3RPJN9l+kM7ryjg
      dCenDYANVabMMQEy2iGjRTBDMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAG
      AQH/AgEBMB0GA1UdDgQWBBRfJt1t0sAlUMBwfeTWVv2v4XNcNjAKBggqhkjOPQQD
      AgNHADBEAiB+MlaTocrG33AiOE8TrH4N2gVrDBo2fAyJ1qDmjxhWvAIgPOoAoWQ9
      qwUVj52L6/Ptj0Tn4Mt6u+bdVr6jEXkZ8f0=
      -----END CERTIFICATE-----
    CERTIFICATE

    service = Integration::KubernetesService.new(nil)

    proxy = entries(:proxy)

    stub_request(:get, 'http://localhost/apis/route.openshift.io/v1').
      with(
        headers: {
          'Accept'=>'application/json',
          'Authorization'=>'Bearer token',
        }).
      to_return(status: 200, body: {
        kind: "APIResourceList",
        apiVersion: "v1",
        groupVersion: "route.openshift.io/v1",
        resources: [
          { name: "routes", singularName: "", namespaced: true, kind: "Route", verbs: %w(create delete deletecollection get list patch update watch), categories: ["all"] },
        ]
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    stub_request(:get, 'http://localhost/apis/route.openshift.io/v1/namespaces/zync/routes?labelSelector=3scale.created-by=zync,3scale.tenant_id=298486374,3scale.ingress=proxy,3scale.service_id=2').
      with(
        headers: {
          'Accept'=>'application/json',
          'Authorization'=>'Bearer token',
        }).
      to_return(status: 200, body: {
        kind: 'RouteList',
        apiVersion: 'route.openshift.io/v1',
        metadata: { selfLink: '/apis/route.openshift.io/v1/namespaces/zync/routes', resourceVersion: '651341' },
        items: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

    service.call(proxy)
  end
end
