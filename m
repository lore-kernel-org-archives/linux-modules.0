Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916031064E
	for <linux-modules@vger.kernel.org>; Fri, 29 Aug 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464876; cv=none; b=mUIG+JgeGmLJdtjp20O5cjyma8+VY9KQyeqtqNqYPJqNLTIdoshjzcRcfb6Ko0+FD0QInfo0K9vNfeDyIx3ewg3HA59bo4xa6TNmob3lMU1r75toPdbuG3KZWqC4qVVsIDDxbYN4OR24NGpEXXeEmkpImhK1DbZzOGAGSTeQHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464876; c=relaxed/simple;
	bh=HAvzKytnoUkJmif830vACBYuc4i5mIbg0Ge6+UpzfJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4IiRC83aLVwtFhmaEA7k//p+yAD1ORg7xkgQRQlQONzr3pOq8cKAvVDsAFzTPjki03qNEqqAsc85x1bL7HetiEoNi48akWe8fpn7ZPfo3YWDMZjkEPIbfDY3f6bhEFo7ddz3XeerFyKDL9BfqfYhOjxp0XbtOvlslE8/VwRuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNcZnBe/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNcZnBe/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so11015675e9.1
        for <linux-modules@vger.kernel.org>; Fri, 29 Aug 2025 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464873; x=1757069673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzWK5ktBAXMKEip0pMwXuQ+LMz45Er37x59lYOQDEQc=;
        b=NNcZnBe/m8THClDDboyth+1POb+d4nTnlTAYnz/UCSNQT8VoTRSdNghLRH9vCMEyX7
         ujrYO8V4HlwthPPiCPoKTbU3aRuyilet+FtT/qn6W9sW6lV6DfpZlbLeVtiAx0mymGIM
         yq820heCzdiThkwz3EbrlFF+s1Hkh0Ro8+utYuhYYjXPyeFu1fE4GgfoBv1hVn+kkb3G
         GKHKPjwAc/11gD7rofTCC2OWADXg3hobs7RbJfllxA+enEezkal2/6fVQNyqyhb7nuLu
         aQ5D9OFihNR67hQDqvsbffLsHIzge+CHSGxU4Qz+0g7VLYdEt1nedzmPJ5DEDafROUWn
         79IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464873; x=1757069673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzWK5ktBAXMKEip0pMwXuQ+LMz45Er37x59lYOQDEQc=;
        b=pEH8bNbvcY4W61skehp03xFN3rehr3BtakxlkQ6Dr12hgYlZF1HWLG/YxcmWb4ebls
         QqeUA/jo2IkmmffhMsysUqGb6sNNHlnZB1tivYM5IG8uYTmuh450Ikr9Pn1zWL4dM5sO
         rEbZ3dVvHLdnKr4jq5HcvJWfTlBJN8N+MErO1PxvzeqicdRHWV0Gf4qHJFT5WX2Bi9Hm
         8CqEbER3OlmFg0kUATDVPTShKhEyi8GT3fDOguB07eN1yB4wpKWSq9+LbWFVTiyOQYbo
         XYyClwGi2Cx/45UQFPkX/N6yHXgEsBAcXGAW6K0OCayLrBigyFtnZrnSIwahz6S8Ez/6
         +NOg==
X-Forwarded-Encrypted: i=1; AJvYcCULJP4VudK+UORkpMMJLoMt+HFfeWCBPwuZsnFFfuyhjbt3WB2X1FNn+fyev5bBUnTxm+9Y5Ycsvp/oKVKy@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4cxc/gMcIAaOX0sbTTERNJsU2rv6BJV2DKrUPkOr/wPKwIyf
	NrO/AJNp6mivL1ow7VR8FRADVDwc28mXOCrIP1AG3HsOEVi2YbzDUOD+bDgc2LWpUqY8tKdxYO8
	RVk6Z2op5LbPaLvpSaQ==
X-Google-Smtp-Source: AGHT+IGnly/av0KHtbsEt0YxJt41btV3bsiIzWd21FF8oQs3ujT3eSzg5vuOKzY8Bw/eXCf7KCDZaZBKghFBcok=
X-Received: from wmbdw13.prod.google.com ([2002:a05:600c:638d:b0:45b:8079:102c])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:21c8:b0:3c9:39f3:7af9 with SMTP id ffacd0b85a97d-3c939f37eadmr7626880f8f.9.1756464872992;
 Fri, 29 Aug 2025 03:54:32 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:11 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-4-sidnayyar@google.com>
Subject: [PATCH 03/10] modpost: create entries for kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/export-internal.h | 7 +++++++
 scripts/mod/modpost.c           | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index d445705ac13c..4123c7592404 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -69,4 +69,11 @@
 	    ".long " #crc					"\n" \
 	    ".previous"						"\n")
 
+#define SYMBOL_FLAGS(sym, flags)					\
+	asm("	.section \"___kflagstab+" #sym "\",\"a\""	"\n"	\
+	    "__flags_" #sym ":"					"\n"	\
+	    "	.byte " #flags					"\n"	\
+	    "	.previous"					"\n"	\
+	)
+
 #endif /* __LINUX_EXPORT_INTERNAL_H__ */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5ca7c268294e..f5ce7aeed52d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -244,6 +244,11 @@ static struct symbol *alloc_symbol(const char *name)
 	return s;
 }
 
+static uint8_t get_symbol_flags(const struct symbol *sym)
+{
+	return sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0;
+}
+
 /* For the hash of exported symbols */
 static void hash_add_symbol(struct symbol *sym)
 {
@@ -1865,6 +1870,9 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
 			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
+
+		buf_printf(buf, "SYMBOL_FLAGS(%s, 0x%02x);\n",
+			   sym->name, get_symbol_flags(sym));
 	}
 
 	if (!modversions)
-- 
2.51.0.338.gd7d06c2dae-goog

