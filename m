Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB23C2798
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729723; cv=none; b=Y1FQja0sYNBU5OQs45o7hpXT2crAtkk8T4v2aw0M+svDdSixRw4wZx2QIWEczelEHyhLP12g0n43EsGDV84qZic6ZC9t9Lht2oRubGHZGdd20BolsnFLKGJV41uUFIu8BT97r2QhuMvH30lEt9f3npBozYSRbAOwztOz4rx6EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729723; c=relaxed/simple;
	bh=Bb1KMrLqycT1mJTEbsbAR/yPkfis88j4rK2phU3dd5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SkES4xoFVpsN2Rr66pXb5FLfrThggz22i8Gh2uP7OXPu5rwBl7jtYnB+9wegGgrxxNAihAuA8eG/6SIIwv8n1Y63KUvid0jI8/WatP+0x2jIbErshtD3FTrK/hc5myPBpQms4WTsERL+7jfp0n2T1kmedcLXc4CpI7CIpYfuYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeTWH3E5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeTWH3E5"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48372facfedso72060855e9.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729720; x=1773334520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBYdKguW4OR7832WAjw0ax/pGR/ObsDBsVmddi7GUko=;
        b=GeTWH3E58TZXYykT+YTk2W0CvHwg+oB/gc7GKfkDBBtS23oyRdK68pKoGKN0Z+mlx0
         msULwJ/u6BQitz9M3oru+4V3K241i3+M7Pv2fNELKKS0lYR3ZwL13CVHivLAN5dfXkNh
         MXzdKB5arkDjyHB8aDApNS1eKVacpaJphSO/Yfd3Lxc/MlWfispc+4Hv0YrLOntkcTnB
         rrBRTIXqNH0LbpvU6KiqoEF/nlSijgjABuMX2f1pcV9hIrPS+v5szMCYhMz5FKXgk4Yc
         pqyjf482QCLyICY4AjbvaYxuaHQi6ZHNDxo+KnhI0x92IAfKl6pcFKppG3EVelLvn+ud
         AFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729720; x=1773334520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBYdKguW4OR7832WAjw0ax/pGR/ObsDBsVmddi7GUko=;
        b=wHkk/WtE21PRqQU5SvIFyBii6X1q9xzyqvWjqNaALufdRbYBq6clQCXXzUCP6Njo0z
         FZWY/iYqf01BE94dzHZ0X/hKpTL+5FOmxV1ohevSNYIM5Qd489Qdf1n3FAuJ6Qahv2vq
         3m6qhjfnyt42PTyBa1c4UyGeOONzD07ofORGu3y7sn5GKDnM4SGmYw2UB7F3BuKQG5Vc
         LWmVS89B3WOOLb1SNA8280Mfx1fzEc7Q4prhUud6w2nt438p4NwqaUqUU0Krs68Rk+g9
         g1RksFGY4hfwAMGqEao+FT8lfVi5UQ6pdUugLp/UcZwNvJp2eM62MovVUFmbZqedo38+
         wVRg==
X-Gm-Message-State: AOJu0Yx908ppM3E+HxP/3EWUvJbCgeOhu1nk1g4jXpV2CnyOO3nOw7hF
	ZUjk14StX3jXKy1bbnsTgvUtxE5KZ2wXQtrqoZNDCmVj3jBE8HWqtVBUe7f49nxfpsy/vKwkwQ5
	LH0Dz97rBR+K5mtVkJQ==
X-Received: from wmbd24.prod.google.com ([2002:a05:600c:58d8:b0:483:248b:3e95])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6814:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-4851ee9c2admr52391175e9.13.1772729720453;
 Thu, 05 Mar 2026 08:55:20 -0800 (PST)
Date: Thu, 05 Mar 2026 16:55:17 +0000
In-Reply-To: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-1-6a76bf8b83c7@google.com>
Subject: [PATCH v4 1/8] define ksym_flags enumeration to represent kernel
 symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbol is GPL only.

The said bitset is introduced in subsequent patches and will contain
values of kernel symbol flags. These bitset will then be used to infer
flag values rather than fragmenting ksymtab for separating symbols with
different flag values, thereby eliminating the need to fragment the
ksymtab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {

-- 
2.53.0.473.g4a7958ca14-goog

