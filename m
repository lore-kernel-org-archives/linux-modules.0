Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DD4F7994
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667473; cv=none; b=o9BFM+VFr3lJXWVcWQGROOnGtWHkIMilR4OcNXdhGKqIxrh2hrqfK6wsZ9usSYoL63mox+ZZm2Nqr0THWU2vJoM/SVZug/sypyFGpPDwy7g2UwYIKfl/dLqIangfkn5JA/EU1k/cfY0oaM/nbTEGhqi9KC210ahP2I3mGDEli0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667473; c=relaxed/simple;
	bh=N96lQhtnzU8bkmmt82baCctVBSF7Uia4qP3gtkWiwLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXV7EIMcmK/9meB7FxgBHF5maRCNEI8XWwZlFtKWp2dby+B0qReYnDkFd/KCCQxN27ukFPe3cpR/zXL9SGrypZD4PA+ZNEqEpQ+fsGY6vNxV2IZFHfxCHnl/RoMoDpk5s1JcW/xkZ/+Aw9Fl/qUcIjYvU/grncGhWb37OqyipJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO+3/pI/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO+3/pI/"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so5903370a34.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667464; x=1785272264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmkeGJdto86FHCQc0XNSEguCjWINd8O0DQoc+nU0950=;
        b=DO+3/pI/rLRzqEVBWCVN+Y5ny0gmSaEUvLfHt8MJpWGnACqTVIxoNZwffeml/MHxB0
         gdWBjgPm1U8yqKgJkntLQGtuV+SQbHvcEKhyvse1cxfE79eT2lfywAa4mmNr5+nTZuvU
         NfHCSdlGvjYRD3BYm3AfwiNkX4wpmlFFxlbWZSeg75808ep56zKifxWRtlA/n2jGpTnE
         w4kF2pCaF2MF84EuDAIVB2xJWtuRWr+xcsrj726016UIIGrAE9rtLoSgPKEdHZ4PbUwt
         xDU6T3j97gUJwAJuqwtx44e9536h3q9a9oGcoapaPRFbUi2WNYm+U0VoN0ht8ecXbhVr
         QhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667464; x=1785272264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmkeGJdto86FHCQc0XNSEguCjWINd8O0DQoc+nU0950=;
        b=SqEdzxVLAJTqNgxvFmfe5n6C945Jus79FwsIEiZ/z5wqYQiLNScFT4gnRpAl0AqhXJ
         sloiPZ/7X59WdvtTKsi88WRKas6N6eLdYnlAES4K6D2kQzbM87I2Oi3Bxex3RRa1Jahf
         xZUvGkK/N8/A/giK+xHD3xNWCpRAomF4ooKSkbT1jSRpt6MvWMmFChdjPLV1FfS75n1u
         LvuVI1f+IHKlnw/TfVWb55jDuI2wkuk8xGkq66VxbWfrN5KPfeiuHVEwde89SPz7M0D4
         +bgegGQOh1Rg1AMn8Ne2tAkkChrin4zj4sZq8LKu1ABKnUUgVsZoVr0mYGIvteL5244i
         DBOQ==
X-Forwarded-Encrypted: i=1; AHgh+RroOvbauUPsVjCcNrS21xF+DzvUI2/mPI1y1HkCHlgrbkVuPTdzZgIvySonhwSDWFHeS1MrY/bb9u2COyJC@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyCIsAKXKGF1n/Uj1gVCQOgpTkhS5Co7AgKszUYSysnqTjpo2
	9Nbug7UpY418xfrYiltX9qeLkrGPn6cBn+p7D6fo4IWZjtO6gnpxZGQsOKQpWw==
X-Gm-Gg: AfdE7cnTOf3ksBBa2acIvnQfBet0SH4gN+Du/0PyagQNyhLNY9zBqtIADC8tOHG8uc2
	hAZyps9KNl3ZHS+baoL/3zausXJaKymBB/9BL/FexUEMBnpUBMrPz01M3mvEhXX1G4V+BLn5vB5
	//tS7Nmgrdxt4g7UCI/nl0s0r4YFFqQAM8/l3a9ypDJi9Dd6QlZ3d76O00/G3qGX47mQGZHpaXr
	izV3x24lLFDk41X2rAHN/RGcSpjmXWejsImYTtOBHl4oBFL2AWe4feO/tHx2HbQ4IrLPhBuCOny
	7yp72IMQP/3VsI1ZwC+kat00TJ1+BZKvBRKiYnD76vHK8udHhIoqTMn8V2Hni2ufExbx5xK/4cU
	LkG/2LjFUf25aqvV4cOo2tZBoVeL38wxWF+Hx0KB5C6AFOVGwourm5fqSWbqlNro9T5ltbRj+JZ
	3bKS5AF2XGo9uXPVmneRclvvq21bWmp1pYbkIhfIOVvfg2VYkQBAmlFHLNcKVA+z6c8WjZC+ur7
	qu7A/4zSXashbpaGhVhlO88AQ==
X-Received: by 2002:a05:6830:2316:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7eda0704f95mr10881604a34.9.1784667463408;
        Tue, 21 Jul 2026 13:57:43 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:43 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:16 -0600
Subject: [PATCH v7 27/29] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-27-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=5915;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=N96lQhtnzU8bkmmt82baCctVBSF7Uia4qP3gtkWiwLQ=;
 b=sP65ir73TClkppbzOP0V+KYmmT2gM0pjq98BIJtPmzTh1Ty+3CTdB+Kp95pwEOkc5WpLv8Xta
 HD6lWD3U53DAUf4B4LiBWwGrVP7S0PQ7vRdyuvfnYcWAqZJx/Az7e7+
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The body of ddebug_attach_module_classes() is just a code-block that
finds the contiguous subrange of classmaps matching on modname, and
saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).  We will
reuse this macro shortly.

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which already segments the builtin pr_debug
descriptors on their mod_name boundaries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v3: expand block-comment in ddebug_add_module

v2: move RvB after SoB

finish hoist - drop old fn - ddebug_attach_module_classes

the v1 rev left the old ddebug_attach_module_classes in place, but it
is completely redundant now, since it already lost the list-linking
job it was doing.

It was being cut out later in the patchset (in the unsent API
adaptation phase), but for cleaner review, lets excise it now.

OLD all-in-1-series (pre split into reviewable chunks)

v10?- reordered params to match kdoc

v12- refactor/rename: s/dd_mark_vector_subrange/dd_set_module_subrange/

1. Renamed the macro from dd_mark_vector_subrange to
   dd_set_module_subrange to better reflect its purpose of narrowing a
   vector to a module-specific subrange.

2. Simplified the arguments by removing the redundant _dst, as the _di
   pointer already provides access to the target _ddebug_info struct.

3. Refactored for Clarity: Instead of overwriting the struct's start
   pointer while the for_subvec loop is using it to iterate, I
   introduced a temporary __start variable. This avoids the "subtle"
   side effect and makes the logic easier to follow.

4. Updated Documentation: Improved the comment block to explicitly
   state that the macro scans for the first match and counts
   contiguous elements.

fiuxp
---
 lib/dynamic_debug.c | 80 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 905277fa495b..b5bc2cc8c400 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1176,34 +1176,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
-{
-	struct ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		} else if (nc) {
-			/* end of matching classmaps */
-			break;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
-	}
-}
+/*
+ * dd_set_module_subrange - find matching subrange of classmaps
+ * @_i:   caller-provided index var
+ * @_sp:  cursor into @_vec
+ * @_di:  pointer to the struct _ddebug_info to be narrowed
+ * @_vec: name of the vector member (must have .start and .len)
+ *
+ * Narrow a _ddebug_info's vector (@_vec) of classmaps to the
+ * contiguous subrange of elements where ->mod_name matches
+ * @__di->mod_name.  This is primarily for builtins, loadable modules
+ * have only their classmaps, and dont need this sub-selection.
+ */
+#define dd_set_module_subrange(_i, _sp, _di, _vec) ({			\
+	struct _ddebug_info *__di = (_di);				\
+	typeof(__di->_vec.start) __start = NULL;			\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, __di, _vec) {				\
+		if (!strcmp((_sp)->mod_name, __di->mod_name)) {		\
+			if (!__nc++)					\
+				__start = (_sp);			\
+		} else if (__nc) {					\
+			break; /* end of consecutive matches */		\
+		}							\
+	}								\
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+	__di->_vec.len = __nc;						\
+})
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1212,6 +1212,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1224,17 +1226,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name (as supplied in di by its
-	 * callers) lives in .rodata and is immortal. For loaded
-	 * modules, name points at the name[] member of struct module,
-	 * which lives at least as long as this struct ddebug_table.
+	 * For built-in modules, di is a partial cursor into the
+	 * builtin dyndbg data; the descriptors are the subrange
+	 * matching the modname, but the classmaps are the full set.
+	 * We find and set the relevant subrange of classmaps here.
+	 *
+	 * The modname string is in .rodata, the descriptors and
+	 * classmaps are in writable .data. All are immortal.
+	 *
+	 * For loaded modules, mod_name points at the name[] member
+	 * of struct module, and the descriptors and classmaps point
+	 * at the module's ELF sections; all have lifetimes matching
+	 * the module's presence.
 	 */
 	dt->info = *di;
-
-	INIT_LIST_HEAD(&dt->link);
-
-	if (di->maps.len)
-		ddebug_attach_module_classes(dt, di);
+	dd_set_module_subrange(i, cm, &dt->info, maps);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);

-- 
2.55.0

