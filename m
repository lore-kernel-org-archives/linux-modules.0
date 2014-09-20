Return-Path: <md@linux.it>
Date: Sat, 20 Sep 2014 21:10:52 +0200
From: Marco d'Itri <md@linux.it>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [patch 2/2] Add the man page for kmod(8)
Message-ID: <20140920191052.GA8101@bongo.bofh.it>
References: <20140917031225.559902121@bongo.bofh.it>
 <20140917031328.089606663@bongo.bofh.it>
 <CAKi4VAJ5oS2xpfYN-h0OcoVqv2Qs_5Scef7VP=ygzZx7xtVBYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
In-Reply-To: <CAKi4VAJ5oS2xpfYN-h0OcoVqv2Qs_5Scef7VP=ygzZx7xtVBYg@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sep 20, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> I can't see how he could be an author of the kmod tool.
Better?

-- 
ciao,
Marco

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=add_kmod_man

Add the man page for kmod(8)

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
+        <firstname>Lucas</firstname>
+        <surname>De Marchi</surname>
+        <email>lucas.de.marchi@gmail.com</email>
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
+      Maintained by Lucas De Marchi and others.
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

--oyUTqETQ0mS9luUI--
