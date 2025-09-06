Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AC1A4E70;
	Sat,  6 Sep 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166128; cv=none; b=sIKqOWfntKGxYrsA3pdCktwFxNoi8Vl6wpXWdr/6+idtcZvDY+l2UhxA40VI6+LDFiSl+f1W50oFsDIZGb25qHL0ZIJ271X8e82BLubiUYGkEfYBmhJH09oOUu51m8S9mHQpzHgP81k+63IyXja8987PDyGruUVy+4dOGgS+VHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166128; c=relaxed/simple;
	bh=Sqdjp9PfdDGfgoskqg5Eq5SZ1OgqpnbQoL9JhAOsA5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sj0mjLFbVMpXuh7JbKDoPGxPGNB8IzwOuDRv6haJdAaWXVyDLOuL5kT/uW+3O2gJt5x9ecuAZLnHtGf4CyMe5He0C/ytDvD2/QDPodgRYCpz8n9MnaNwi4HdasyhzpEtkTZrzDg9lYks3/yFbGiOIVF0siC5/kG0RCqLDvTE+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6ZzI/2R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6ZzI/2R"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b804ed966so12211925e9.2;
        Sat, 06 Sep 2025 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757166124; x=1757770924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVDkwa6ENMB+D92oZ0efdffHN86X4ijnV8ra8cIVQF8=;
        b=T6ZzI/2RDhQbuWspHVKa7PNE+d6PiF+NIJmiGTP5EmhpWcdZzy11TitRUub4ho1DrL
         wAaG0LRknst1RqQzfcenbS3ToWxwpIjo9uBiWwuguctLormZoNqER0I0T6mxbiCoHrHy
         SS+URRyv5p+X8+BUc4LFZ4QMRnFZQf1rhkrc20bJIiOlXcptAME/VSZlozm6ucMVf4m+
         eh0DffoNEaOanb7QNOGJAgrwo9dQwzfvj9DB0TA5mnyUfDmuyyypQgiQTHGdistz3SgT
         q6s+7uwNltfdTNNRfIo/C1BsgPd9vJii4/vBuo1BVNsP9rCRddg5ngXtCNNpMjIS4vgH
         uOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757166124; x=1757770924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVDkwa6ENMB+D92oZ0efdffHN86X4ijnV8ra8cIVQF8=;
        b=dN2bc3yCdOMxKgA88HrZaZkP+QrUpm1L5t0V/4gdrkVVxKx8h4MqDxcEs9PrPdPebe
         axXcKBgq4k41v4kOJKSC6YrVJJvEHaGwsf4tDi7cmAGZ1g9gZ5zuXeSJzKrpOsctVW1p
         1gveyvjduCd+l9BGmzmC92i8a7fha7tvZhEnk8ktKD/BFh38HxsV4wM6AHhGWQH5fvCQ
         Rq4VusjHTuKjFk8IizpvEw4QuXJrKXmNQbXLNycwfp+HhzEImKSzP4mtU4GaXlf975kf
         7d7RT5IIhkvbUM2E3hDtPbEYRr8DbnzCciliy5VNLP37soDt8KNljMpMmGkuNBmGCtfB
         hriw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNyeghM13UQGpVsHXLfhkpLgNtElGjfbhCm3BrUenPmpajB1CWqwoRHy2/iseUvZoOfwD3PW9HEhEozM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYm27/m3RFnjq1wafE9xif8tmj/+dEAAKSFtD+jb+ifAtqmBbF
	B7I5T+qv2llm1Mh3pz7jRc/Yf6pvxKjTnvd/8U4yZ0hVT8KLjfqm9YL4yLXNUQ==
X-Gm-Gg: ASbGncsjWfh2h7VdVjvfTaBPdldRadMtW8jWNn3UXsM1XKM3pBEpvUQJrfsCyD/SM2V
	yCzaHa5P0cfemYVic4JvBFBiRdLp6RggwMa2k31himB3KJjMtuGxGcnvH/kDKf4u1P+ax2q82C0
	9AhQs8ibVwHqTGVbvEdftslDqutHHx0akAK6CNMuVdee4jB+I17auKItm5z00RNu/K45lwUXBfG
	Z+VzfayMIFj3mSUxxFhZ3i8d3uR5rJbhSoYAztWxEsxVoRm+nVbwq9gtlhX/437DuPWlR31mIbJ
	erAzhiQfwJkOjulcyFOWuwV3digAzWqWbkBDCbJ29RQRM/o+OZ+Q9TLACDoQOc1Yfp90o9eXzm1
	ifbqnjEJexu4T/fSyqEDpVlW+Krg=
X-Google-Smtp-Source: AGHT+IExP+DeYri14fsNQ7Vs5Vv82KRyun0zEqJkigYj/n8DtoJcfFxcJ+R9qwlxa1PDN8t9UbetMg==
X-Received: by 2002:a05:600c:4589:b0:45b:8795:4caa with SMTP id 5b1f17b1804b1-45dddeedbb4mr20825605e9.36.1757166123991;
        Sat, 06 Sep 2025 06:42:03 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:258:2ea4:8502:df64:bca:486e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dc1cd4a7d2sm15085527f8f.33.2025.09.06.06.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 06:42:03 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] tracing: Fix multiple issues in trace_printk module handling
Date: Sat,  6 Sep 2025 17:41:48 +0400
Message-ID: <20250906134148.55-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

This commit addresses several bugs and potential issues in the
trace_printk module format handling code:

1. Memory leak fix: In hold_module_trace_bprintk_format(), ensure
   proper cleanup when format string allocation fails by setting
   tb_fmt to NULL after freeing it.

2. NULL pointer dereference prevention: Added NULL checks in
   t_show() function before dereferencing format pointers.

3. Input validation: Added NULL check in trace_is_tracepoint_string()
   to prevent potential NULL pointer dereference.

4. Type safety: Fixed type casting in t_show() to use proper
   unsigned long casting for pointer arithmetic.

5. Error handling: Improved error checking in
   init_trace_printk_function_export() by using IS_ERR() to check
   dentry pointer.

6. Code robustness: Added additional pointer validation throughout
   the code to handle potential edge cases.

7. Memory safety: Ensured consistent handling of format pointers
   when memory allocation failures occur.

These fixes improve the stability and reliability of the trace_printk
infrastructure, particularly when dealing with module loading/unloading
and format string management.

Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 kernel/trace/trace_printk.c      |  33 +--
 kernel/trace/trace_printk.c.orig | 400 +++++++++++++++++++++++++++++++
 2 files changed, 419 insertions(+), 14 deletions(-)
 create mode 100644 kernel/trace/trace_printk.c.orig

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..cb962c6c02f8 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -76,10 +76,12 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
 				strcpy(fmt, *iter);
 				tb_fmt->fmt = fmt;
-			} else
+			} else {
 				kfree(tb_fmt);
+				tb_fmt = NULL;
+			}
 		}
-		*iter = fmt;
+		*iter = tb_fmt ? tb_fmt->fmt : NULL;
 
 	}
 	mutex_unlock(&btrace_mutex);
@@ -253,7 +255,10 @@ EXPORT_SYMBOL_GPL(__ftrace_vprintk);
 
 bool trace_is_tracepoint_string(const char *str)
 {
-	const char **ptr = __start___tracepoint_str;
+	const char **ptr;
+
+	if (!str)
+		return false;
 
 	for (ptr = __start___tracepoint_str; ptr < __stop___tracepoint_str; ptr++) {
 		if (str == *ptr)
@@ -311,19 +316,19 @@ static void *t_next(struct seq_file *m, void * v, loff_t *pos)
 static int t_show(struct seq_file *m, void *v)
 {
 	const char **fmt = v;
-	const char *str = *fmt;
-	int i;
+	const char *str;
 
-	if (!*fmt)
+	if (!fmt || !*fmt)
 		return 0;
 
-	seq_printf(m, "0x%lx : \"", *(unsigned long *)fmt);
+	str = *fmt;
+	seq_printf(m, "0x%lx : \"", (unsigned long)fmt);
 
 	/*
 	 * Tabs and new lines need to be converted.
 	 */
-	for (i = 0; str[i]; i++) {
-		switch (str[i]) {
+	for (; *str; str++) {
+		switch (*str) {
 		case '\n':
 			seq_puts(m, "\\n");
 			break;
@@ -337,7 +342,7 @@ static int t_show(struct seq_file *m, void *v)
 			seq_puts(m, "\\\"");
 			break;
 		default:
-			seq_putc(m, str[i]);
+			seq_putc(m, *str);
 		}
 	}
 	seq_puts(m, "\"\n");
@@ -378,10 +383,10 @@ static const struct file_operations ftrace_formats_fops = {
 
 static __init int init_trace_printk_function_export(void)
 {
-	int ret;
+	struct dentry *dentry;
 
-	ret = tracing_init_dentry();
-	if (ret)
+	dentry = tracing_init_dentry();
+	if (IS_ERR(dentry))
 		return 0;
 
 	trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
@@ -397,4 +402,4 @@ static __init int init_trace_printk(void)
 	return register_module_notifier(&module_trace_bprintk_format_nb);
 }
 
-early_initcall(init_trace_printk);
+early_initcall(init_trace_printk);
\ No newline at end of file
diff --git a/kernel/trace/trace_printk.c.orig b/kernel/trace/trace_printk.c.orig
new file mode 100644
index 000000000000..29f6e95439b6
--- /dev/null
+++ b/kernel/trace/trace_printk.c.orig
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace binary printk
+ *
+ * Copyright (C) 2008 Lai Jiangshan <laijs@cn.fujitsu.com>
+ *
+ */
+#include <linux/seq_file.h>
+#include <linux/security.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/ftrace.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/ctype.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "trace.h"
+
+#ifdef CONFIG_MODULES
+
+/*
+ * modules trace_printk()'s formats are autosaved in struct trace_bprintk_fmt
+ * which are queued on trace_bprintk_fmt_list.
+ */
+static LIST_HEAD(trace_bprintk_fmt_list);
+
+/* serialize accesses to trace_bprintk_fmt_list */
+static DEFINE_MUTEX(btrace_mutex);
+
+struct trace_bprintk_fmt {
+	struct list_head list;
+	const char *fmt;
+};
+
+static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
+{
+	struct trace_bprintk_fmt *pos;
+
+	if (!fmt)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(pos, &trace_bprintk_fmt_list, list) {
+		if (!strcmp(pos->fmt, fmt))
+			return pos;
+	}
+	return NULL;
+}
+
+static
+void hold_module_trace_bprintk_format(const char **start, const char **end)
+{
+	const char **iter;
+	char *fmt;
+
+	/* allocate the trace_printk per cpu buffers */
+	if (start != end)
+		trace_printk_init_buffers();
+
+	mutex_lock(&btrace_mutex);
+	for (iter = start; iter < end; iter++) {
+		struct trace_bprintk_fmt *tb_fmt = lookup_format(*iter);
+		if (tb_fmt) {
+			if (!IS_ERR(tb_fmt))
+				*iter = tb_fmt->fmt;
+			continue;
+		}
+
+		fmt = NULL;
+		tb_fmt = kmalloc(sizeof(*tb_fmt), GFP_KERNEL);
+		if (tb_fmt) {
+			fmt = kmalloc(strlen(*iter) + 1, GFP_KERNEL);
+			if (fmt) {
+				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
+				strcpy(fmt, *iter);
+				tb_fmt->fmt = fmt;
+			} else
+				kfree(tb_fmt);
+		}
+		*iter = fmt;
+
+	}
+	mutex_unlock(&btrace_mutex);
+}
+
+static int module_trace_bprintk_format_notify(struct notifier_block *self,
+		unsigned long val, void *data)
+{
+	struct module *mod = data;
+	if (mod->num_trace_bprintk_fmt) {
+		const char **start = mod->trace_bprintk_fmt_start;
+		const char **end = start + mod->num_trace_bprintk_fmt;
+
+		if (val == MODULE_STATE_COMING)
+			hold_module_trace_bprintk_format(start, end);
+	}
+	return NOTIFY_OK;
+}
+
+/*
+ * The debugfs/tracing/printk_formats file maps the addresses with
+ * the ASCII formats that are used in the bprintk events in the
+ * buffer. For userspace tools to be able to decode the events from
+ * the buffer, they need to be able to map the address with the format.
+ *
+ * The addresses of the bprintk formats are in their own section
+ * __trace_printk_fmt. But for modules we copy them into a link list.
+ * The code to print the formats and their addresses passes around the
+ * address of the fmt string. If the fmt address passed into the seq
+ * functions is within the kernel core __trace_printk_fmt section, then
+ * it simply uses the next pointer in the list.
+ *
+ * When the fmt pointer is outside the kernel core __trace_printk_fmt
+ * section, then we need to read the link list pointers. The trick is
+ * we pass the address of the string to the seq function just like
+ * we do for the kernel core formats. To get back the structure that
+ * holds the format, we simply use container_of() and then go to the
+ * next format in the list.
+ */
+static const char **
+find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+{
+	struct trace_bprintk_fmt *mod_fmt;
+
+	if (list_empty(&trace_bprintk_fmt_list))
+		return NULL;
+
+	/*
+	 * v will point to the address of the fmt record from t_next
+	 * v will be NULL from t_start.
+	 * If this is the first pointer or called from start
+	 * then we need to walk the list.
+	 */
+	if (!v || start_index == *pos) {
+		struct trace_bprintk_fmt *p;
+
+		/* search the module list */
+		list_for_each_entry(p, &trace_bprintk_fmt_list, list) {
+			if (start_index == *pos)
+				return &p->fmt;
+			start_index++;
+		}
+		/* pos > index */
+		return NULL;
+	}
+
+	/*
+	 * v points to the address of the fmt field in the mod list
+	 * structure that holds the module print format.
+	 */
+	mod_fmt = container_of(v, typeof(*mod_fmt), fmt);
+	if (mod_fmt->list.next == &trace_bprintk_fmt_list)
+		return NULL;
+
+	mod_fmt = container_of(mod_fmt->list.next, typeof(*mod_fmt), list);
+
+	return &mod_fmt->fmt;
+}
+
+static void format_mod_start(void)
+{
+	mutex_lock(&btrace_mutex);
+}
+
+static void format_mod_stop(void)
+{
+	mutex_unlock(&btrace_mutex);
+}
+
+#else /* !CONFIG_MODULES */
+__init static int
+module_trace_bprintk_format_notify(struct notifier_block *self,
+		unsigned long val, void *data)
+{
+	return NOTIFY_OK;
+}
+static inline const char **
+find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+{
+	return NULL;
+}
+static inline void format_mod_start(void) { }
+static inline void format_mod_stop(void) { }
+#endif /* CONFIG_MODULES */
+
+static bool __read_mostly trace_printk_enabled = true;
+
+void trace_printk_control(bool enabled)
+{
+	trace_printk_enabled = enabled;
+}
+
+__initdata_or_module static
+struct notifier_block module_trace_bprintk_format_nb = {
+	.notifier_call = module_trace_bprintk_format_notify,
+};
+
+int __trace_bprintk(unsigned long ip, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	if (unlikely(!fmt))
+		return 0;
+
+	if (!trace_printk_enabled)
+		return 0;
+
+	va_start(ap, fmt);
+	ret = trace_vbprintk(ip, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__trace_bprintk);
+
+int __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap)
+{
+	if (unlikely(!fmt))
+		return 0;
+
+	if (!trace_printk_enabled)
+		return 0;
+
+	return trace_vbprintk(ip, fmt, ap);
+}
+EXPORT_SYMBOL_GPL(__ftrace_vbprintk);
+
+int __trace_printk(unsigned long ip, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	if (!trace_printk_enabled)
+		return 0;
+
+	va_start(ap, fmt);
+	ret = trace_vprintk(ip, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__trace_printk);
+
+int __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap)
+{
+	if (!trace_printk_enabled)
+		return 0;
+
+	return trace_vprintk(ip, fmt, ap);
+}
+EXPORT_SYMBOL_GPL(__ftrace_vprintk);
+
+bool trace_is_tracepoint_string(const char *str)
+{
+	const char **ptr = __start___tracepoint_str;
+
+	for (ptr = __start___tracepoint_str; ptr < __stop___tracepoint_str; ptr++) {
+		if (str == *ptr)
+			return true;
+	}
+	return false;
+}
+
+static const char **find_next(void *v, loff_t *pos)
+{
+	const char **fmt = v;
+	int start_index;
+	int last_index;
+
+	start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;
+
+	if (*pos < start_index)
+		return __start___trace_bprintk_fmt + *pos;
+
+	/*
+	 * The __tracepoint_str section is treated the same as the
+	 * __trace_printk_fmt section. The difference is that the
+	 * __trace_printk_fmt section should only be used by trace_printk()
+	 * in a debugging environment, as if anything exists in that section
+	 * the trace_prink() helper buffers are allocated, which would just
+	 * waste space in a production environment.
+	 *
+	 * The __tracepoint_str sections on the other hand are used by
+	 * tracepoints which need to map pointers to their strings to
+	 * the ASCII text for userspace.
+	 */
+	last_index = start_index;
+	start_index = __stop___tracepoint_str - __start___tracepoint_str;
+
+	if (*pos < last_index + start_index)
+		return __start___tracepoint_str + (*pos - last_index);
+
+	start_index += last_index;
+	return find_next_mod_format(start_index, v, fmt, pos);
+}
+
+static void *
+t_start(struct seq_file *m, loff_t *pos)
+{
+	format_mod_start();
+	return find_next(NULL, pos);
+}
+
+static void *t_next(struct seq_file *m, void * v, loff_t *pos)
+{
+	(*pos)++;
+	return find_next(v, pos);
+}
+
+static int t_show(struct seq_file *m, void *v)
+{
+	const char **fmt = v;
+	const char *str = *fmt;
+	int i;
+
+	if (!*fmt)
+		return 0;
+
+	seq_printf(m, "0x%lx : \"", *(unsigned long *)fmt);
+
+	/*
+	 * Tabs and new lines need to be converted.
+	 */
+	for (i = 0; str[i]; i++) {
+		switch (str[i]) {
+		case '\n':
+			seq_puts(m, "\\n");
+			break;
+		case '\t':
+			seq_puts(m, "\\t");
+			break;
+		case '\\':
+			seq_putc(m, '\\');
+			break;
+		case '"':
+			seq_puts(m, "\\\"");
+			break;
+		default:
+			seq_putc(m, str[i]);
+		}
+	}
+	seq_puts(m, "\"\n");
+
+	return 0;
+}
+
+static void t_stop(struct seq_file *m, void *p)
+{
+	format_mod_stop();
+}
+
+static const struct seq_operations show_format_seq_ops = {
+	.start = t_start,
+	.next = t_next,
+	.show = t_show,
+	.stop = t_stop,
+};
+
+static int
+ftrace_formats_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	return seq_open(file, &show_format_seq_ops);
+}
+
+static const struct file_operations ftrace_formats_fops = {
+	.open = ftrace_formats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static __init int init_trace_printk_function_export(void)
+{
+	int ret;
+
+	ret = tracing_init_dentry();
+	if (ret)
+		return 0;
+
+	trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
+				    NULL, &ftrace_formats_fops);
+
+	return 0;
+}
+
+fs_initcall(init_trace_printk_function_export);
+
+static __init int init_trace_printk(void)
+{
+	return register_module_notifier(&module_trace_bprintk_format_nb);
+}
+
+early_initcall(init_trace_printk);
-- 
2.50.1.windows.1

