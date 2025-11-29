Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33B3101AA
	for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445991; cv=none; b=cXfNGC9sZ4bdHO0ON3PbrKtanlo6P2gPR++N++3Vk7VOshnXby84GBPrIGRtdAtXrLyvXIuDv4ZVanFv8tZn91Fl3GwoQ/6ucqI062IMIvesHtAgXh3p1uaqE1W0eZFdg2wQFlnBYsYfoY3HqYA/80pNxHoxLhzvF1M0UHa928s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445991; c=relaxed/simple;
	bh=aXRfTaRGpbjnvq4qNF4ICgoIeZ9X37XGGJ9DOHdRdJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKWsczYRybCzourf300bkAvtYLGl8Liv6I/dXItaq3CShM7gE2O9uc2t3LX6RHHyYAqMnHUVVaQtqoRFRhaGyilNG2bxsJv03zS/6X675sFat693Fnmc8InV9N3hLG2HTRDKFlw/JG06jlpDLszzuiySnRmaRHMEj0674v8Bt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6DPDfQs; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6DPDfQs"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64107188baeso2529785d50.3
        for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445988; x=1765050788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPhKot9RrW+4OVEYlhiH2dUrdgdiYCdMeVF+/QnKJpk=;
        b=E6DPDfQsPNWAb6D2lI9b0X6TBBj2eFaYhEsBoAJ40/UINhdMcPLUq4g4N0f086rtN5
         9GlrXiFbdvLCtL7O/xaiquIZMHXm2gpJJL2t06lgzxXsWnoenc89EiIs1Mq1Rhju7WPX
         UEm91Fh1otLKkVV7FzxQMKF7dO2gZ8hoQioBoQsf46X2pNU5Vi4YYrAggQHVqvm1X8h3
         Dlq4PD/yM6DZ4giHiBfVrxRfwoBCKTs4BXw9Pc/3G6G5yxHeZsCrW/13l954ptXOkX6W
         OdT+3pW/v9a5GTvV7dh18kWP6PMDBFXFP1tgRfWY016k8blbuOrnFegkAImp00kq4w7p
         EunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445988; x=1765050788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPhKot9RrW+4OVEYlhiH2dUrdgdiYCdMeVF+/QnKJpk=;
        b=UTn/QMVlDpYzQudElsr7zrWe8W2as0IJ9/SfSRrqP5RuA8xR3s+p0FGXoO4oZS1sMj
         6iESKrmTNHpl5AehHDCz4GjH/Ljj0GTP0U6DAF4FOHAx6iWxYawd1WEJ7Et/wu+0vkAa
         2XDONCHRbUJWR/+K4ooFRYs18dbAUQnSQ8Gssc4SGV8IJKyB03Z22rscpr8dg5t3Pgxk
         QYYgUPgOKYFybhyCIoiJGggCWhJmswdwaXAp0s6mndXJjWGIbGj5YRJj6aALrpkeIcid
         4Jfat/ffmgSjmeZTC2Wa8+2qSWpM+TC7IWVj21YjP5XE/i7pq7nxz0FZ99ivDLjHEz78
         rmTg==
X-Forwarded-Encrypted: i=1; AJvYcCWsUCI0btFC4QrlbuUuilsQFSxJt6FUoWMhGxDNqb4xjDbQGCG97B+bg0AYLLfEvdPEJAgblfvsKCIA5t7I@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaAOG7LbZn8+P7Wx+pg2f5U+OUWdYW9+i+Kn+ZPkEUN2oxfWi
	hY37O6Dk9mTxnZCq0Q/UgWN1fYzo8QbSBTrUUpDFdCrb8VwagB5DHSJg
X-Gm-Gg: ASbGncvZbdCjxVDGV/esdZYbwhdEOk32G+gzxV6JagYcklqxMj1ZokqvxbkpIiTggfH
	rle8bpAdpU7aCXtMxYraCCZYYVkRwRqMG4eTnUejeZ2TVYjsPcr3mPWYFSd37eZ8/Wd7uggupyz
	A2Ofkbx8FkGsW0/s7ihpuW/dPWD0p1osVFjLM4Zk3FrLu8VrUAz4iVo3BpQ7TAs/w7kTsOsORWV
	vQ3sgSGKclz3Sav9NpCiSqPW3Q53hT4kTKMtXzM1BljVi8inI82xaum+Yxwl0Yyc+kgZFUr3Fct
	D2wY6QcGjVwf710zwfV8+LL6E1DKJwxBRHuoaHzNUTYoOC44FthJD1JeueXaTi3lutuDV9SWdrD
	vP5yYt0H3cERzEqB51XGInJMoiwVuofuYFkRX9Iy6P1neNUFIz5DCK643AgBtkSfwz/kgHrEYS+
	hK1nWbysg=
X-Google-Smtp-Source: AGHT+IFRuLzNF/pr0yH2EAr8HpHXwB/WeGCGG0/WvzHFo3LTXr61qS6+iXCYXDnEXYF/tuCt9oopew==
X-Received: by 2002:a05:690e:144a:b0:63e:233a:3ee6 with SMTP id 956f58d0204a3-64302b0fc69mr23750126d50.38.1764445988022;
        Sat, 29 Nov 2025 11:53:08 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad101115asm28750137b3.29.2025.11.29.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:07 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 3/3] tracing: move tracing declarations from kernel.h to a dedicated header
Date: Sat, 29 Nov 2025 14:53:02 -0500
Message-ID: <20251129195304.204082-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129195304.204082-1-yury.norov@gmail.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing is a half of the kernel.h in terms of LOCs, although it's a
self-consistent part. Move it to a separate header.

This is a pure move, except for removing a few 'extern's.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 MAINTAINERS             |   1 +
 include/linux/kernel.h  | 195 +-------------------------------------
 include/linux/tracing.h | 203 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/tracing.h

diff --git a/MAINTAINERS b/MAINTAINERS
index be6a4217caa5..706bbb5da263 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26071,6 +26071,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/*
 F:	fs/tracefs/
 F:	include/linux/trace*.h
+F:	include/linux/tracing.h
 F:	include/trace/
 F:	kernel/trace/
 F:	kernel/tracepoint.c
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b879bfea948..265c0d31f369 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -27,6 +27,7 @@
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
+#include <linux/tracing.h>
 #include <linux/panic.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
@@ -190,200 +191,6 @@ enum system_states {
 };
 extern enum system_states system_state;
 
-/*
- * General tracing related utility functions - trace_printk(),
- * tracing_on/tracing_off and tracing_start()/tracing_stop
- *
- * Use tracing_on/tracing_off when you want to quickly turn on or off
- * tracing. It simply enables or disables the recording of the trace events.
- * This also corresponds to the user space /sys/kernel/tracing/tracing_on
- * file, which gives a means for the kernel and userspace to interact.
- * Place a tracing_off() in the kernel where you want tracing to end.
- * From user space, examine the trace, and then echo 1 > tracing_on
- * to continue tracing.
- *
- * tracing_stop/tracing_start has slightly more overhead. It is used
- * by things like suspend to ram where disabling the recording of the
- * trace is not enough, but tracing must actually stop because things
- * like calling smp_processor_id() may crash the system.
- *
- * Most likely, you want to use tracing_on/tracing_off.
- */
-
-enum ftrace_dump_mode {
-	DUMP_NONE,
-	DUMP_ALL,
-	DUMP_ORIG,
-	DUMP_PARAM,
-};
-
-#ifdef CONFIG_TRACING
-void tracing_on(void);
-void tracing_off(void);
-int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
-
-extern void tracing_start(void);
-extern void tracing_stop(void);
-
-static inline __printf(1, 2)
-void ____trace_printk_check_format(const char *fmt, ...)
-{
-}
-#define __trace_printk_check_format(fmt, args...)			\
-do {									\
-	if (0)								\
-		____trace_printk_check_format(fmt, ##args);		\
-} while (0)
-
-/**
- * trace_printk - printf formatting in the ftrace buffer
- * @fmt: the printf format for printing
- *
- * Note: __trace_printk is an internal function for trace_printk() and
- *       the @ip is passed in via the trace_printk() macro.
- *
- * This function allows a kernel developer to debug fast path sections
- * that printk is not appropriate for. By scattering in various
- * printk like tracing in the code, a developer can quickly see
- * where problems are occurring.
- *
- * This is intended as a debugging tool for the developer only.
- * Please refrain from leaving trace_printks scattered around in
- * your code. (Extra memory is used for special buffers that are
- * allocated when trace_printk() is used.)
- *
- * A little optimization trick is done here. If there's only one
- * argument, there's no need to scan the string for printf formats.
- * The trace_puts() will suffice. But how can we take advantage of
- * using trace_puts() when trace_printk() has only one argument?
- * By stringifying the args and checking the size we can tell
- * whether or not there are args. __stringify((__VA_ARGS__)) will
- * turn into "()\0" with a size of 3 when there are no args, anything
- * else will be bigger. All we need to do is define a string to this,
- * and then take its size and compare to 3. If it's bigger, use
- * do_trace_printk() otherwise, optimize it to trace_puts(). Then just
- * let gcc optimize the rest.
- */
-
-#define trace_printk(fmt, ...)				\
-do {							\
-	char _______STR[] = __stringify((__VA_ARGS__));	\
-	if (sizeof(_______STR) > 3)			\
-		do_trace_printk(fmt, ##__VA_ARGS__);	\
-	else						\
-		trace_puts(fmt);			\
-} while (0)
-
-#define do_trace_printk(fmt, args...)					\
-do {									\
-	static const char *trace_printk_fmt __used			\
-		__section("__trace_printk_fmt") =			\
-		__builtin_constant_p(fmt) ? fmt : NULL;			\
-									\
-	__trace_printk_check_format(fmt, ##args);			\
-									\
-	if (__builtin_constant_p(fmt))					\
-		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
-	else								\
-		__trace_printk(_THIS_IP_, fmt, ##args);			\
-} while (0)
-
-extern __printf(2, 3)
-int __trace_bprintk(unsigned long ip, const char *fmt, ...);
-
-extern __printf(2, 3)
-int __trace_printk(unsigned long ip, const char *fmt, ...);
-
-/**
- * trace_puts - write a string into the ftrace buffer
- * @str: the string to record
- *
- * Note: __trace_bputs is an internal function for trace_puts and
- *       the @ip is passed in via the trace_puts macro.
- *
- * This is similar to trace_printk() but is made for those really fast
- * paths that a developer wants the least amount of "Heisenbug" effects,
- * where the processing of the print format is still too much.
- *
- * This function allows a kernel developer to debug fast path sections
- * that printk is not appropriate for. By scattering in various
- * printk like tracing in the code, a developer can quickly see
- * where problems are occurring.
- *
- * This is intended as a debugging tool for the developer only.
- * Please refrain from leaving trace_puts scattered around in
- * your code. (Extra memory is used for special buffers that are
- * allocated when trace_puts() is used.)
- *
- * Returns: 0 if nothing was written, positive # if string was.
- *  (1 when __trace_bputs is used, strlen(str) when __trace_puts is used)
- */
-
-#define trace_puts(str) ({						\
-	static const char *trace_printk_fmt __used			\
-		__section("__trace_printk_fmt") =			\
-		__builtin_constant_p(str) ? str : NULL;			\
-									\
-	if (__builtin_constant_p(str))					\
-		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
-	else								\
-		__trace_puts(_THIS_IP_, str, strlen(str));		\
-})
-extern int __trace_bputs(unsigned long ip, const char *str);
-extern int __trace_puts(unsigned long ip, const char *str, int size);
-
-extern void trace_dump_stack(int skip);
-
-/*
- * The double __builtin_constant_p is because gcc will give us an error
- * if we try to allocate the static variable to fmt if it is not a
- * constant. Even with the outer if statement.
- */
-#define ftrace_vprintk(fmt, vargs)					\
-do {									\
-	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt __used		\
-		  __section("__trace_printk_fmt") =			\
-			__builtin_constant_p(fmt) ? fmt : NULL;		\
-									\
-		__ftrace_vbprintk(_THIS_IP_, trace_printk_fmt, vargs);	\
-	} else								\
-		__ftrace_vprintk(_THIS_IP_, fmt, vargs);		\
-} while (0)
-
-extern __printf(2, 0) int
-__ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern __printf(2, 0) int
-__ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
-#else
-static inline void tracing_start(void) { }
-static inline void tracing_stop(void) { }
-static inline void trace_dump_stack(int skip) { }
-
-static inline void tracing_on(void) { }
-static inline void tracing_off(void) { }
-static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
-
-static inline __printf(1, 2)
-int trace_printk(const char *fmt, ...)
-{
-	return 0;
-}
-static __printf(1, 0) inline int
-ftrace_vprintk(const char *fmt, va_list ap)
-{
-	return 0;
-}
-static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
-#endif /* CONFIG_TRACING */
-
 /* Rebuild everything on CONFIG_DYNAMIC_FTRACE */
 #ifdef CONFIG_DYNAMIC_FTRACE
 # define REBUILD_DUE_TO_DYNAMIC_FTRACE
diff --git a/include/linux/tracing.h b/include/linux/tracing.h
new file mode 100644
index 000000000000..1989e6328c59
--- /dev/null
+++ b/include/linux/tracing.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TRACING_H
+#define _LINUX_TRACING_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/instruction_pointer.h>
+#include <linux/stringify.h>
+
+/*
+ * General tracing related utility functions - trace_printk(),
+ * tracing_on/tracing_off and tracing_start()/tracing_stop
+ *
+ * Use tracing_on/tracing_off when you want to quickly turn on or off
+ * tracing. It simply enables or disables the recording of the trace events.
+ * This also corresponds to the user space /sys/kernel/tracing/tracing_on
+ * file, which gives a means for the kernel and userspace to interact.
+ * Place a tracing_off() in the kernel where you want tracing to end.
+ * From user space, examine the trace, and then echo 1 > tracing_on
+ * to continue tracing.
+ *
+ * tracing_stop/tracing_start has slightly more overhead. It is used
+ * by things like suspend to ram where disabling the recording of the
+ * trace is not enough, but tracing must actually stop because things
+ * like calling smp_processor_id() may crash the system.
+ *
+ * Most likely, you want to use tracing_on/tracing_off.
+ */
+
+enum ftrace_dump_mode {
+	DUMP_NONE,
+	DUMP_ALL,
+	DUMP_ORIG,
+	DUMP_PARAM,
+};
+
+#ifdef CONFIG_TRACING
+void tracing_on(void);
+void tracing_off(void);
+int tracing_is_on(void);
+void tracing_snapshot(void);
+void tracing_snapshot_alloc(void);
+
+void tracing_start(void);
+void tracing_stop(void);
+
+static inline __printf(1, 2)
+void ____trace_printk_check_format(const char *fmt, ...)
+{
+}
+#define __trace_printk_check_format(fmt, args...)			\
+do {									\
+	if (0)								\
+		____trace_printk_check_format(fmt, ##args);		\
+} while (0)
+
+/**
+ * trace_printk - printf formatting in the ftrace buffer
+ * @fmt: the printf format for printing
+ *
+ * Note: __trace_printk is an internal function for trace_printk() and
+ *       the @ip is passed in via the trace_printk() macro.
+ *
+ * This function allows a kernel developer to debug fast path sections
+ * that printk is not appropriate for. By scattering in various
+ * printk like tracing in the code, a developer can quickly see
+ * where problems are occurring.
+ *
+ * This is intended as a debugging tool for the developer only.
+ * Please refrain from leaving trace_printks scattered around in
+ * your code. (Extra memory is used for special buffers that are
+ * allocated when trace_printk() is used.)
+ *
+ * A little optimization trick is done here. If there's only one
+ * argument, there's no need to scan the string for printf formats.
+ * The trace_puts() will suffice. But how can we take advantage of
+ * using trace_puts() when trace_printk() has only one argument?
+ * By stringifying the args and checking the size we can tell
+ * whether or not there are args. __stringify((__VA_ARGS__)) will
+ * turn into "()\0" with a size of 3 when there are no args, anything
+ * else will be bigger. All we need to do is define a string to this,
+ * and then take its size and compare to 3. If it's bigger, use
+ * do_trace_printk() otherwise, optimize it to trace_puts(). Then just
+ * let gcc optimize the rest.
+ */
+
+#define trace_printk(fmt, ...)				\
+do {							\
+	char _______STR[] = __stringify((__VA_ARGS__));	\
+	if (sizeof(_______STR) > 3)			\
+		do_trace_printk(fmt, ##__VA_ARGS__);	\
+	else						\
+		trace_puts(fmt);			\
+} while (0)
+
+#define do_trace_printk(fmt, args...)					\
+do {									\
+	static const char *trace_printk_fmt __used			\
+		__section("__trace_printk_fmt") =			\
+		__builtin_constant_p(fmt) ? fmt : NULL;			\
+									\
+	__trace_printk_check_format(fmt, ##args);			\
+									\
+	if (__builtin_constant_p(fmt))					\
+		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
+	else								\
+		__trace_printk(_THIS_IP_, fmt, ##args);			\
+} while (0)
+
+__printf(2, 3)
+int __trace_bprintk(unsigned long ip, const char *fmt, ...);
+
+__printf(2, 3)
+int __trace_printk(unsigned long ip, const char *fmt, ...);
+
+/**
+ * trace_puts - write a string into the ftrace buffer
+ * @str: the string to record
+ *
+ * Note: __trace_bputs is an internal function for trace_puts and
+ *       the @ip is passed in via the trace_puts macro.
+ *
+ * This is similar to trace_printk() but is made for those really fast
+ * paths that a developer wants the least amount of "Heisenbug" effects,
+ * where the processing of the print format is still too much.
+ *
+ * This function allows a kernel developer to debug fast path sections
+ * that printk is not appropriate for. By scattering in various
+ * printk like tracing in the code, a developer can quickly see
+ * where problems are occurring.
+ *
+ * This is intended as a debugging tool for the developer only.
+ * Please refrain from leaving trace_puts scattered around in
+ * your code. (Extra memory is used for special buffers that are
+ * allocated when trace_puts() is used.)
+ *
+ * Returns: 0 if nothing was written, positive # if string was.
+ *  (1 when __trace_bputs is used, strlen(str) when __trace_puts is used)
+ */
+
+#define trace_puts(str) ({						\
+	static const char *trace_printk_fmt __used			\
+		__section("__trace_printk_fmt") =			\
+		__builtin_constant_p(str) ? str : NULL;			\
+									\
+	if (__builtin_constant_p(str))					\
+		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
+	else								\
+		__trace_puts(_THIS_IP_, str, strlen(str));		\
+})
+int __trace_bputs(unsigned long ip, const char *str);
+int __trace_puts(unsigned long ip, const char *str, int size);
+
+void trace_dump_stack(int skip);
+
+/*
+ * The double __builtin_constant_p is because gcc will give us an error
+ * if we try to allocate the static variable to fmt if it is not a
+ * constant. Even with the outer if statement.
+ */
+#define ftrace_vprintk(fmt, vargs)					\
+do {									\
+	if (__builtin_constant_p(fmt)) {				\
+		static const char *trace_printk_fmt __used		\
+		  __section("__trace_printk_fmt") =			\
+			__builtin_constant_p(fmt) ? fmt : NULL;		\
+									\
+		__ftrace_vbprintk(_THIS_IP_, trace_printk_fmt, vargs);	\
+	} else								\
+		__ftrace_vprintk(_THIS_IP_, fmt, vargs);		\
+} while (0)
+
+__printf(2, 0) int
+__ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
+
+__printf(2, 0) int
+__ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
+
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
+#else
+static inline void tracing_start(void) { }
+static inline void tracing_stop(void) { }
+static inline void trace_dump_stack(int skip) { }
+
+static inline void tracing_on(void) { }
+static inline void tracing_off(void) { }
+static inline int tracing_is_on(void) { return 0; }
+static inline void tracing_snapshot(void) { }
+static inline void tracing_snapshot_alloc(void) { }
+
+static inline __printf(1, 2)
+int trace_printk(const char *fmt, ...)
+{
+	return 0;
+}
+static __printf(1, 0) inline int
+ftrace_vprintk(const char *fmt, va_list ap)
+{
+	return 0;
+}
+static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
+#endif /* CONFIG_TRACING */
+
+#endif
-- 
2.43.0

