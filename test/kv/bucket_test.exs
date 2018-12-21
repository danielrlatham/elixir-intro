defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.put(bucket, "orange", 12)
    assert KV.Bucket.get(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "orange") == 12
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
