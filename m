Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7C3101A6
	for <linux-modules@vger.kernel.org>; Fri, 29 Aug 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464874; cv=none; b=k68Guf0hhUMKMncNBiYeALw2mQmZNwoyZYwkS32lsI42ZjAtzerGohOdgnOGDJw7A4vsQteroppw3QaTJqd+9Vzed8J28MH1/NO+mCPpBWT0bcNfevq7SZP3O9m+4RZHcUkmePbUWFF9RMPPTMmoZJaYc2PDn8XqGvVsAXquRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464874; c=relaxed/simple;
	bh=o00iDb5UYdIfCyM60Ae3j8Plc64XIahNETckMuCAzEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evh9RgnDFWH/m8iVNeqT6Mlzk7hXIDvpKq35K11SfsTVFjIwU9GDxUFhz1GRMxzIRo804xQCLXXyO9n011L2yxDDGt0PrlDXqanc/zTLlCpJEJ76evDu00QErLEf35xHDxAjAVOKSV7oR6gNomjJPBQLcXq4Z63KtfKoXg3pV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlZ28ScE; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlZ28ScE"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afcb7a3a160so180279766b.2
        for <linux-modules@vger.kernel.org>; Fri, 29 Aug 2025 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464871; x=1757069671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzTerVh/nCBDl27Owgk/DKlFx8Mn2cN/NIkEjSaweuQ=;
        b=HlZ28ScEhlTJqsqRcihNvC+4ZcY6FG7G31PA5SpYEqdHwPtySmu/4g2Y5cFAbrpoBJ
         6dTm1S2tUnqTLjlEEUOLh/cIqXfpKtWXIsdBGxz11dJOtPQ0XDf43DLkIYAoQD3vnvDJ
         WVmrJG5FTo51FDWy57DIqvUocUGNKbk/oB8Csn+elsCNJjxXpwTVsjsfqmzdwYJFAjNZ
         CSvjjmSXEnKePujyZbTqgD2vcrqA1dp0g0VigdPzpIrkl2DQfmiXJhdPMZyoPfWtisL4
         smMKGg3bjvP1rppjnOhd0RDxetBcnO4JMNdVRY1Uip6jMJaD+/7z6xq5m/Mb+zbyCGLh
         FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464871; x=1757069671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzTerVh/nCBDl27Owgk/DKlFx8Mn2cN/NIkEjSaweuQ=;
        b=XQ62QQjCg4R+rlN+zVk9RDXiO/KWTMKqW19vUhkLh53kM+tzWmXLZ1Nu4GCDg0slOV
         Kx4E3Me2anFgQk7haKANl1FjrA6Hj73IRQ4rREMk+S5jACDEp42GZwtw+DQTf/c7N6GP
         rozvwpPoddfnQFHTp/fLaR6tRtsL5Q6behrQGIfFTo6Xx6oZ4/7w/OGbmrBTVCnJEH8r
         2dcOfKG6Zuu53vyjsFpWQ1f+uH2TWEnrPM6oLHx7lUyyzrA9WkjFYnz53wzyBuqhKMSy
         lvVr1hCQqI8iOluvKp0yUd8SpOAd5L9/FM1txuK8a0q+Fd+ffcK/r+eOhel2oS85CQUb
         sZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwuePt6/10NDnPwQeneeG84NXaCz2T/TeTDHo1pIdHNCtn73M+8wTDmUsFF4+rR8uloJ4MZ2eboKkhzHqy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xfoAnK2c5dHW43yBVUcTZlPUCrRHxPMdl3wc8EQ2gx4TVnk6
	vQdfeyLXF3SADu5hbrmiIF5iUFAzEg1MT+FZgVnw41wfW+hdEp9nJuMHw6Xdj3gPJkGjg4v9FU+
	lvkRFzyC+YSkUppOFfA==
X-Google-Smtp-Source: AGHT+IFTtQCdjV7sfltO3GmOq7hzjj4vCpIsNY9YQpuWWop+sd3pviuI1QGFkyDeMWAuOScrxjcHr9lkftkQ/q0=
X-Received: from ejcrx18.prod.google.com ([2002:a17:906:8e12:b0:afe:944f:fea5])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:968c:b0:afd:d9e4:51e7 with SMTP id a640c23a62f3a-afe296bceabmr2540214466b.63.1756464870885;
 Fri, 29 Aug 2025 03:54:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:09 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-2-sidnayyar@google.com>
Subject: [PATCH 01/10] define kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbols GPL only.

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
2.51.0.338.gd7d06c2dae-goog

