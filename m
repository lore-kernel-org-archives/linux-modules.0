Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCH] man/depmod.d: add external keyword description
Date: Thu, 20 Jul 2017 17:09:52 +0300
Message-Id: <20170720140952.12944-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The commit 'depmod: implement external directories support' added
external directories support (see
7da6884e7357ac05772e90f6d7e63b1948103fc4).

This patch documents the extention in the manpage.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 man/depmod.d.xml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index c30c06c5b605..4341a568e8a0 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -75,6 +75,9 @@
             first listed directory and the lowest priority given to the last
             directory listed. The special keyword <command>built-in</command> 
             refers to the standard module directories installed by the kernel.
+            Another special keyword <command>external</command> refers to the
+            list of external directories, defined by the
+            <command>external</command> command.
           </para>
           <para>
             By default, depmod will give a higher priority to 
@@ -110,6 +113,23 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>external <replaceable>kernelversion</replaceable>
+        <replaceable>absolutemodulesdirectory...</replaceable>
+        </term>
+        <listitem>
+          <para>
+            This specifies a list of directories, which will be checked
+            according to the priorities in the <command>search</command>
+            command. The order matters also, the first directory has the higher
+            priority.
+          </para>
+          <para>
+            The <replaceable>kernelversion</replaceable> is a POSIX regular
+            expression or * wildcard, like in the <command>override</command>.
+          </para>
+        </listitem>
+      </varlistentry>
     </variablelist>
   </refsect1>
 
-- 
2.14.0.rc0
