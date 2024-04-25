git checkout main
git pull origin main
cd ..
helm package helm-siterm-agent/
mv siterm-agent-*.tgz helm-siterm-agent/
helm repo index helm-siterm-agent/ --url https://sdn-sense.github.io/helm-siterm-agent/
cd helm-siterm-agent/
echo "======================================================================================"
echo "Built and added. Execute the following commands below if you want to push them to repo"
echo 'git commit -a -m "Add index and new chart"'
echo 'git push origin'
