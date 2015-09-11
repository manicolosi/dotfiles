{:user
 {:plugins [[lein-droid "0.2.4-SNAPSHOT"]
            [com.jakemccrary/lein-test-refresh "0.10.0"]]}
 :dependencies [[pjstadig/humane-test-output "0.7.0"]]
 :injections [(require 'pjstadig.humane-test-output)
              (pjstadig.humane-test-output/activate!)]
 :android-common
 {:android
  {:dependencies ^:replace []
   :sdk-path "/usr/local/Cellar/android-sdk/23.0.2"}}}
