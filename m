Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:37260 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753208AbdJPPuL (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 16 Oct 2017 11:50:11 -0400
From: =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>
To: linux-modules@vger.kernel.org
Cc: christopher.diaz.riv@gmail.com,
        =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>
Subject: [PATCH] man/depmod: Add references in other man pages
Date: Mon, 16 Oct 2017 10:48:42 -0500
Message-Id: <20171016154842.11104-1-chrisadr@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Depmod man page is not referenced in some man pages. This makes it
harder to find through reading documentation.

References added to:

	-man/insmod.xml
	-man/lsmod.xml
	-man/modprobe.xml
	-man/rmmod.xml

Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
---

Hi, this is the first patch that I submit, I know that the changes should
be as atomic as posible, but I'm leaving the four changes as a single
commig since it represents a whole change by itself. If you need me to 
split in four different commits please let me know.

Regards

 man/insmod.xml   | 3 +++
 man/lsmod.xml    | 3 +++
 man/modprobe.xml | 3 +++
 man/rmmod.xml    | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/man/insmod.xml b/man/insmod.xml
index 8ff4e20..3ebdccd 100644
--- a/man/insmod.xml
+++ b/man/insmod.xml
@@ -79,6 +79,9 @@
       <citerefentry>
         <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>
+      <citerefentry>
+        <refentrytitle>depmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>
     </para>
   </refsect1>
 </refentry>
diff --git a/man/lsmod.xml b/man/lsmod.xml
index 8815a7e..588f228 100644
--- a/man/lsmod.xml
+++ b/man/lsmod.xml
@@ -65,6 +65,9 @@
       <citerefentry>
         <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>
+      <citerefentry>
+        <refentrytitle>depmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>
     </para>
   </refsect1>
 </refentry>
diff --git a/man/modprobe.xml b/man/modprobe.xml
index 9cb4476..12d49f2 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -512,6 +512,9 @@
       <citerefentry>
         <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>
+      <citerefentry>
+        <refentrytitle>depmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>
     </para>
   </refsect1>
 </refentry>
diff --git a/man/rmmod.xml b/man/rmmod.xml
index 4b9fad7..e7c7e5f 100644
--- a/man/rmmod.xml
+++ b/man/rmmod.xml
@@ -139,6 +139,9 @@
       <citerefentry>
         <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>
+      <citerefentry>
+        <refentrytitle>depmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>
     </para>
   </refsect1>
 </refentry>
-- 
2.15.0.rc1.dirty

