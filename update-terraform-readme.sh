#!/usr/bin/env bash
echo "Updating terraform README."

for path in terraform/modules/* ; do
  [ -d "${path}" ] || continue
  terraform-docs ${path}
  echo "Updated ${path} README."
done

for path in terraform/aws/accounts/* ; do
  [ -d "${path}" ] || continue
  terraform-docs ${path}
  echo "Updated ${path} README."
done

terraform-docs terraform/github/
echo "Updated terraform/github/ README."
