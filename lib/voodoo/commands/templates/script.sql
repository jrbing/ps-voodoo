-- Datafix <%= name %>
-- Created on: <%= Time.now.localtime.strftime("%m/%d/%Y") %>

spool script.out;

-- Environment Information
select dbname
     , ownerid
     , to_char(sysdate,'YYYY/MM/DD HH:MI:SS')
  from psdbowner;

-- Insert sql inserts/updates/deletes here
