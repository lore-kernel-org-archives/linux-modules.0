Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B821129D
	for <linux-modules@vger.kernel.org>; Tue, 29 Apr 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936060; cv=none; b=VZDIyqqNSXoRt/4zfsTJoIMPVAWW351DHNqeD9YAUi6pXUg6qczJawT2Pf4obncoLlVflqed8+F9Rs1D+3pYTizPwfIwYqcHu/CJs9DUIN2V6JDBvVii6/3QHV+EBfs5GOWDVBRNhFahvoO2fRg6/27m/B1QhaGRKXgv52tN9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936060; c=relaxed/simple;
	bh=/Bic5tMQbn4e9l13Gx+2H4VKZnvHe4be2dvQJf6n6vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAQz8eF++TMMr7eijHGQ2DOtc7ZVFZjTvcKvqNAO01WqouzfML8O1hBugnXtgs16cr3AakidK5QAF46CpSGkSPYO5QJ87MY1JvXNidEndJ2q9V9tGMlMWcAnB9C7cUCQldaNtuG+OwNoodUFzN+AgZofhroK6PbpzVhhJ7/p/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g45me7DC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g45me7DC"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso1004277066b.1
        for <linux-modules@vger.kernel.org>; Tue, 29 Apr 2025 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745936055; x=1746540855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU733MoFmkvJlcQMMp1av039eQ89ojsIQoVLgnbBgjE=;
        b=g45me7DCtmyhpCozfisO74fstponHUSjvYPtdw9SohFiaGmk6Mt3KuE+201uVYEsrm
         dihDcB5uhwkSZVpx+6ZPg/wyW4KvFGwdedFWfgNJoE3Ma3CfIZ9kkxfjkMLnjY+SMQQ0
         jUJkUsxNbx+f6lv8hExnyYnLhY1i830kRya2nSuKevZ5EnFupA5fXiMglpjuwed1WxyZ
         cFYOd0fXTcLGBwhnoqGUbJN8eal0/8Ay9n1tpq+qdOuyE/8V1VFciAoSUWBwY2tJ/HI2
         U5KL/GsfS14VvxOV9tae/tmBGQFk+B6KnhBwOqzmyQROItxC/8Zbqi2GaLO7N26dFGkg
         uHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936055; x=1746540855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU733MoFmkvJlcQMMp1av039eQ89ojsIQoVLgnbBgjE=;
        b=W8TIauO4eAR7boR9c0A30nQyLI43O07gAWcj0USBqsSu9Z6j9mNGpCm9yLglJP0Mtp
         MW7MRswiydGWYaUYEWfFWygVWBLKgYK+G+gN/faZVN9WlgG6EghXmLFaRTku61SKB72V
         Cuu6fpO+b3TJ5byjvzJhbMJiIo7i1XCeCThzh5W0cI7Q6KLaEKko5241xMRACpO14ATM
         DIlD701dYIsnfF4frFLy0gCT88i79B28hHpVwCwe58EaYl6chaLg+pYBx4eTcksemMo8
         LhAR6Uk2meBQhGuObbpsD1m2TzxTrV9Q4u0DOdMiSrANHeC+fy3n8QB9ZGRhuUM7+3PM
         UDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGOkEij0W1RzihswtNA0cy/BU+X+7zjhqS2aVJr+Lj2XphgcnuGY+aukOXvQakCRmvq2Udvi0b4Fp0KN6F@vger.kernel.org
X-Gm-Message-State: AOJu0YxALlSjjxHbd8EZGrMcYgC3ObIjxwvVQCopGoKUf1ZCZNNzSnFy
	QlXI3XI64RgszguIhu/VO6fc3sqp005Ff3L3mmK1uWX3EUcVbOvAZt0wHj5Q8Lw=
X-Gm-Gg: ASbGnctcdJQk6aYZZ0M2UBeSHBmpygasafuINkCgHznyRVvwIDJU2Nhy9EL86ir0/rn
	9cnWKmM/tUNe9koBwxyJYv/W1mJsLRY2t65Uug4GUaOUHh28+WD7Bzh2aCnxf8fST69Q3lwRAcv
	6JHmRVB+DHuW9WkjQtSgdBa4hcHDawiPQTGSNBLacsAfPCWmA9pX3l/KbhO+wf408tqFCQZkDyc
	1inghtejYg86N52AajpOiBw2Gh+IqciffWMxZs+/hfYSJZiwgi0AG8gypo+ovyMSKQLGBSy5TTK
	U6yCxxt2WtR1BuaeylI2wjS6QTqVKt37qXbDc/ZgUEM=
X-Google-Smtp-Source: AGHT+IEP+h6/ELvWESlBbC9Pz4Pr39fyYlZm3Lx8N+sfkjC9Cz4qRUIr4fHaPTtWKEstTwDU0myT1w==
X-Received: by 2002:a17:907:2d2c:b0:ac2:baab:681c with SMTP id a640c23a62f3a-acec4e41bb2mr443404066b.28.1745936055090;
        Tue, 29 Apr 2025 07:14:15 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec9e47497sm112320666b.160.2025.04.29.07.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:14:14 -0700 (PDT)
Message-ID: <7b13da9f-39f2-4007-931b-519d8e7d1ab6@suse.com>
Date: Tue, 29 Apr 2025 16:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] modpost: Create modalias for builtin modules
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
 <bb0d887760a474e5e7f9db0e9933eee81a5d9ea3.1745591072.git.legion@kernel.org>
 <cf3ff619-6177-42e1-8f64-74cf4cbb8672@suse.com>
 <aBCkNh0Q2hwpMchj@example.org> <aBDK0G6OUUcEmzvZ@example.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aBDK0G6OUUcEmzvZ@example.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 14:49, Alexey Gladkov wrote:
> On Tue, Apr 29, 2025 at 12:04:44PM +0200, Alexey Gladkov wrote:
>>> I'm not sure it's best to overload this data in this way. I think mixing
>>> actual files and "logical" modules in the modules list is somewhat
>>> confusing.
>>>
>>> An alternative would be to keep a single module struct for vmlinux and
>>> record the discovered aliases under it?
>>
>> It is possible to extend struct module_alias and add the module name. The
>> problem is that alias is added by module_alias_printf() and we will have
>> to add the module name to the arguments to each do_entry handler in
>> addition to struct module where there is already a name (but in our case
>> it is vmlinux).
>>
>> I can do that if you think it's a better way.
> 
> If I don't add separate entries for each builtin module, the patch will
> look like this:
> [...]

I see, that didn't turn out as well as I envisioned. One more approach
would be to track builtin modules separately. A patch is below. I'm not
sure if it's better.


diff --git a/include/linux/module.h b/include/linux/module.h
index 7250b4a527ec..6225793ddcd4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -257,14 +257,10 @@ extern void cleanup_module(void);
 	__PASTE(type,			\
 	__PASTE(__, name)))))))
 
-#ifdef MODULE
 /* Creates an alias so file2alias.c can find device table. */
 #define MODULE_DEVICE_TABLE(type, name)			\
 extern typeof(name) __mod_device_table(type, name)	\
   __attribute__ ((unused, alias(__stringify(name))))
-#else  /* !MODULE */
-#define MODULE_DEVICE_TABLE(type, name)
-#endif
 
 /* Version of form [<epoch>:]<version>[-<extra-version>].
  * Or for CVS/RCS ID version, everything but the number is stripped.
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index dff1799a4c79..28a4c045f66c 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1471,8 +1471,8 @@ static const struct devtable devtable[] = {
 /* Create MODULE_ALIAS() statements.
  * At this time, we cannot write the actual output C source yet,
  * so we write into the mod->dev_table_buf buffer. */
-void handle_moddevtable(struct module *mod, struct elf_info *info,
-			Elf_Sym *sym, const char *symname)
+void handle_moddevtable(struct module *mod, struct elf_info *info, Elf_Sym *sym,
+			const char *symname)
 {
 	void *symval;
 	char *zeros = NULL;
@@ -1509,6 +1509,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	typelen = name - type;
 	name += strlen("__");
 
+	if (mod->is_vmlinux)
+		// XXX Check if the module doesn't already exist?
+		mod = new_module(modname, modnamelen, true);
+
 	/* Handle all-NULL symbols allocated into .bss */
 	if (info->sechdrs[get_secindex(info, sym)].sh_type & SHT_NOBITS) {
 		zeros = calloc(1, sym->st_size);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index be89921d60b6..f39e3456e021 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -168,9 +168,12 @@ char *get_line(char **stringp)
 	return orig;
 }
 
-/* A list of all modules we processed */
+/* A list of all modules (vmlinux or *.ko) we processed */
 LIST_HEAD(modules);
 
+/* A list of all builtin modules we processed */
+LIST_HEAD(builtin_modules);
+
 static struct module *find_module(const char *filename, const char *modname)
 {
 	struct module *mod;
@@ -183,7 +186,7 @@ static struct module *find_module(const char *filename, const char *modname)
 	return NULL;
 }
 
-static struct module *new_module(const char *name, size_t namelen)
+struct module *new_module(const char *name, size_t namelen, bool is_builtin)
 {
 	struct module *mod;
 
@@ -207,7 +210,10 @@ static struct module *new_module(const char *name, size_t namelen)
 	 */
 	mod->is_gpl_compatible = true;
 
-	list_add_tail(&mod->list, &modules);
+	if (is_builtin)
+		list_add_tail(&mod->list, &builtin_modules);
+	else
+		list_add_tail(&mod->list, &modules);
 
 	return mod;
 }
@@ -1573,7 +1579,7 @@ static void read_symbols(const char *modname)
 	}
 
 	/* strip trailing .o */
-	mod = new_module(modname, strlen(modname) - strlen(".o"));
+	mod = new_module(modname, strlen(modname) - strlen(".o"), false);
 
 	/* save .no_trim_symbol section for later use */
 	if (info.no_trim_symbol_len) {
@@ -2021,11 +2027,23 @@ static void write_if_changed(struct buffer *b, const char *fname)
 static void write_vmlinux_export_c_file(struct module *mod)
 {
 	struct buffer buf = { };
+	struct module_alias *alias, *next;
 
 	buf_printf(&buf,
-		   "#include <linux/export-internal.h>\n");
+		   "#include <linux/export-internal.h>\n"
+		   "#include <linux/module.h>\n");
 
 	add_exported_symbols(&buf, mod);
+
+	list_for_each_entry(mod, &builtin_modules, list) {
+		list_for_each_entry_safe(alias, next, &mod->aliases, node) {
+			buf_printf(&buf, "MODULE_ALIAS_MODNAME(\"%s\", \"%s\");\n",
+					mod->name, alias->str);
+			list_del(&alias->node);
+			free(alias);
+		}
+	}
+
 	write_if_changed(&buf, ".vmlinux.export.c");
 	free(buf.p);
 }
@@ -2114,7 +2132,7 @@ static void read_dump(const char *fname)
 
 		mod = find_module(fname, modname);
 		if (!mod) {
-			mod = new_module(modname, strlen(modname));
+			mod = new_module(modname, strlen(modname), false);
 			mod->dump_file = fname;
 		}
 		s = sym_add_exported(symname, mod, gpl_only, namespace);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 9133e4c3803f..f2b6d25f00ff 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -107,7 +107,7 @@ struct module_alias {
 };
 
 /**
- * struct module - represent a module (vmlinux or *.ko)
+ * struct module - represent a module (vmlinux, a builtin module, or *.ko)
  *
  * @dump_file: path to the .symvers file if loaded from a file
  * @aliases: list head for module_aliases
@@ -199,6 +199,8 @@ static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 	return !is_mapping_symbol(name);
 }
 
+struct module *new_module(const char *name, size_t namelen, bool is_builtin);
+
 /* symsearch.c */
 void symsearch_init(struct elf_info *elf);
 void symsearch_finish(struct elf_info *elf);

-- 
Cheers,
Petr
