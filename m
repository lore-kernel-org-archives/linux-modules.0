Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F803DA5C1
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729672; cv=none; b=L5T4ohGomt+GSK4aXtUqtSCNiUC5NVHFugJRyv0IrW2XUQ7/4Ktvjw85Pr5PvJE7E3usJcSk2b/YGkdAZ1rPi2q+Ce+fj/o8vYAF3JhA/AMlNmpqZMsi7Gk9o6FicnTiVfYIEKCtYTsYRd7mwGh06GjFwEI0SNXE1kmIEVOlrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729672; c=relaxed/simple;
	bh=Bb1KMrLqycT1mJTEbsbAR/yPkfis88j4rK2phU3dd5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxfLik/DNbMV/cDtm65UYSi97aH+Y/tjPRcqKGbRw3TsNGgq5cRzbZuZcEKXvjRGAsGkL/4J+HAF6unH6sZAwZAu8LVDvG30TIKB4rsxQ7OjAzVdPGyZ9kGRXR3CDu0Z5E3wyrZCynKr2ZGWVdBtiAmgJ1UCtUmDkaszut0lUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sluHBj5J; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sluHBj5J"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so63225475e9.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729669; x=1773334469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBYdKguW4OR7832WAjw0ax/pGR/ObsDBsVmddi7GUko=;
        b=sluHBj5JfAAw33DMwk5C0P7EoC2p68PVq8RIlHzHG68iPKFgypy4gCkU+ybrrSk/mR
         +T4SjJSSWUaJSOFm4/INlHG7cYUMj9WxW7/H+3Nl1LpMOeQLUmZgrRmvtkAFzBNdah12
         gS+n8yoY2V+rSh+zyKmbofIW/TYWQejCb+fQa2gp4pKtsGpNT34YmIgF9Xw+e70a16vJ
         O2mhpZERm/kgnJ/c67dnCwCdzTx0XKdFX/9k5OwGivtd5h8RiBsT/fARLO18LmHP+1po
         WQaSA4CQsyKZWJTH9Ef8qbx86eEvWCuDZ9r5qyBZkrGCRrMG/9ZWvdpXrqEOYKgt0YBy
         B2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729669; x=1773334469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBYdKguW4OR7832WAjw0ax/pGR/ObsDBsVmddi7GUko=;
        b=HcDYnhAJetOcWVVjUHUxv4nxzOJSIq4JGg2q+t00uuOwi8ZvZjK3y+N1L1H85tsJzv
         Sam8yqnJdTvYMxcHF3/LouPfoRiDT1ntQPl0lsehP7HoL7GAeIPKPZxIu3KVwT9WqhcN
         bDOqH33PEtvMO3j8BdHMEZqQT2JtDgvNrJWTjwl5kFxJ5IHYIsYVIqZ3JrICpjYdkCmv
         iZCUU/1u5RQ8q5imADqJ+R2HArBjV5TXa/Dq/W2UUAL0wV4BREonVyR79s1cbfhWdli0
         m5FqM9iV38ylLItfs3ln3fETcgKFGlxUSirQJKMcE6Z6Lr3g7iphh6f3QNh/d90iWww4
         9TGA==
X-Gm-Message-State: AOJu0YwISPmMM2MgZ+HEDv0nXhNB2o7MEbRWBt9zXFm8MtTEfzPmwLwC
	LGjmEsiQoGTUbzG0eoYYLFj+0YJnKka4zY0CHe8Vx22u+D3se6JoI9GZwnO8udbevipu2FTocq7
	pSZY48Z5uZtGaNCmWhw==
X-Received: from wmnf7.prod.google.com ([2002:a05:600c:43c7:b0:480:1bc3:e23c])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e88:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-485198800afmr106818555e9.22.1772729668779;
 Thu, 05 Mar 2026 08:54:28 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:21 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-1-4fe6eea27e30@google.com>
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

