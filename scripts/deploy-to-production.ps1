# Production Deployment Script
# Intergalactic Freight & Trade Corp - Tabs Deployment
# Date: October 20, 2025

# Step 1: Validate deployment first (recommended)
Write-Host "Step 1: Validating deployment to production..." -ForegroundColor Cyan
sf project deploy validate --source-dir force-app/main/default --target-org "wonga myendeki"

# Wait for user confirmation
Read-Host "Press Enter to continue with actual deployment or Ctrl+C to cancel"

# Step 2: Deploy to production
Write-Host "`nStep 2: Deploying to production..." -ForegroundColor Cyan
sf project deploy start --source-dir force-app/main/default --target-org "wonga myendeki"

# Step 3: Verify deployment
Write-Host "`nStep 3: Verifying tabs..." -ForegroundColor Cyan
sf data query --query "SELECT Label, SobjectName FROM TabDefinition WHERE SobjectName IN ('Shipment__c', 'Cargo__c', 'Customs_Document__c')" --target-org "wonga myendeki" --use-tooling-api

Write-Host "`n✅ Deployment completed! Opening org..." -ForegroundColor Green
sf org open --target-org "wonga myendeki" --path "/lightning/setup/ObjectManager/home"
