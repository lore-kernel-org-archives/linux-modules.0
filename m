Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:53070 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbaIQDWh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 16 Sep 2014 23:22:37 -0400
Message-Id: <20140917031328.089606663@bongo.bofh.it>
Date: Wed, 17 Sep 2014 05:12:27 +0200
To: linux-modules@vger.kernel.org
Subject: [patch 2/2] Add the man page for kmod(8)
References: <20140917031225.559902121@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
From: md@Linux.IT (Marco d'Itri)
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--- /dev/null
+++ b/man/kmod.xml
@@ -0,0 +1,126 @@
+<?xml version='1.0'?>
+<!--*-nxml-*-->
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
+        "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
+<refentry id="kmod">
+  <refentryinfo>
+    <title>kmod</title>
+    <productname>kmod</productname>
+
+    <authorgroup>
+      <author>
+        <contrib>Developer</contrib>
+        <firstname>Jon</firstname>
+        <surname>Masters</surname>
+        <email>jcm@jonmasters.org</email>
+      </author>
+      <author>
+        <contrib>Developer</contrib>
+        <firstname>Lucas</firstname>
+        <surname>De Marchi</surname>
+        <email>lucas.de.marchi@gmail.com</email>
+      </author>
+    </authorgroup>
+  </refentryinfo>
+
+  <refmeta>
+    <refentrytitle>kmod</refentrytitle>
+    <manvolnum>8</manvolnum>
+  </refmeta>
+
+  <refnamediv>
+    <refname>kmod</refname>
+    <refpurpose>Program to manage Linux Kernel modules</refpurpose>
+  </refnamediv>
+
+  <refsynopsisdiv>
+    <cmdsynopsis>
+      <command>kmod</command>
+      <arg rep='repeat'><option>OPTIONS</option></arg>
+      <arg><replaceable>COMMAND</replaceable></arg>
+      <arg rep='repeat'><option>COMMAND_OPTIONS</option></arg>
+    </cmdsynopsis>
+  </refsynopsisdiv>
+
+  <refsect1><title>DESCRIPTION</title>
+    <para>
+      <command>kmod</command> is a multi-call binary which implements the
+      programs used to control Linux Kernel modules.  Most users will only
+      run it using its other names.
+    </para>
+  </refsect1>
+
+  <refsect1><title>OPTIONS</title>
+    <variablelist>
+      <varlistentry>
+        <term><option>-V</option> <option>--version</option>
+        </term>
+        <listitem>
+          <para>Show the program version and exit.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term><option>-h</option> <option>--help</option>
+        </term>
+        <listitem>
+          <para>Show the help message.</para>
+        </listitem>
+      </varlistentry>
+    </variablelist>
+  </refsect1>
+
+  <refsect1><title>COMMANDS</title>
+    <variablelist>
+      <varlistentry>
+        <term><command>help</command></term>
+        <listitem>
+          <para>Show the help message.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term><command>list</command></term>
+        <listitem>
+          <para>List the currently loaded modules.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term><command>static-nodes</command></term>
+        <listitem>
+          <para>Output the static device nodes information provided by
+           the modules of the currently running kernel version.</para>
+        </listitem>
+      </varlistentry>
+    </variablelist>
+  </refsect1>
+
+  <refsect1>
+    <title>COPYRIGHT</title>
+    <para>
+      This manual page originally Copyright 2014, Marco d'Itri.
+      Maintained by Jon Masters and others.
+    </para>
+  </refsect1>
+
+  <refsect1><title>SEE ALSO</title>
+    <para>
+      <citerefentry>
+        <refentrytitle>lsmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>rmmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>insmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>modprobe</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>depmod</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>
+    </para>
+  </refsect1>
+</refentry>
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,5 +1,5 @@
 MAN5 = depmod.d.5 modprobe.d.5 modules.dep.5
-MAN8 = depmod.8 insmod.8 lsmod.8 rmmod.8 modprobe.8 modinfo.8
+MAN8 = kmod.8 depmod.8 insmod.8 lsmod.8 rmmod.8 modprobe.8 modinfo.8
 MAN_STUB = modules.dep.bin.5
 
 AM_V_XSLT = $(AM_V_XSLT_$(V))


