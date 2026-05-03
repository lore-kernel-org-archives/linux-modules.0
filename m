Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03BE571
	for <linux-modules@vger.kernel.org>; Sun,  3 May 2026 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766748; cv=none; b=CrJ1fDdFNSx8dlD/AIn+8GdanlX9nHUyH9b6eYCUUTdpA4iM2hwVNrETvY+2V6OWeWXwkwOsSrsCUKPlxH6JDz7rj/ffQdZNGn5yBfw0WkOBtjaTEfNcQYzgytPcexXBK+To0grMPkMMCCJgLv1G18UX9L8Qzkkt5vcPSW73Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766748; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqKJUCP++tA/kA59XbQfvyIIR3CaE7xk4sDFS7FQfhaMLA7EwxD3rQVIOrQjF6tfQXOH85DIKu8gM4WYaKkWazxYwFwJockVOK+CN/n9yi9s2FkF+NTXQlni4X+s8lAxmOStkQuZzOZYh5UNJIi5iCbSjdOMc17iNKixv6/RXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3VOCxne; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3VOCxne"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dd73b7c757so1464603a34.0
        for <linux-modules@vger.kernel.org>; Sat, 02 May 2026 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766745; x=1778371545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=g3VOCxnecD/pohIyg7NcjpGfMQ+HU4vwtWCmXltWCtycAbEglYyepfJz2h8UhRuGRy
         WUWQfZowyrzQyUp+Ll9F8DAFFIDmbt0/6OvK7ZTpO8poIkY63ULjRQFNz22ynTIMhD5F
         skvj10gFxkfzQaQaBkgchHFfUw5rNrYgWtTBY9jBx/cCojOxfa+lehENsKFW+D/m5HjL
         gTHyDpCfDuVmmnkxOjPAPLpcC7AzNdUwu6Ej131P71Cscv4RyaRBb6ZpfjUVIjSH6s6u
         w2iVxOpf9OGJOD7FLNIkUepmVbYwVPAypj5SyI5yihoxbkO3meft9h3mFJ0eDoPSpbqI
         zIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766745; x=1778371545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=cTY3m08kwiZuI8SsZAsnwHKdk3zkVqUTis8y3cZ2y0xWBjIhIAl+FXgAKgtgNwXsMr
         nq0PlM4EsAuIoKJJQtYqTSaCQkEwBmxRXw7A/ehzm62J3E9SaE296LxFnnm5SePdV+RL
         5XZamf5BWGlC5CYD6H63++aSNzuzyDkjmq/fgYxKZIIS8JFIY6IKIq1DcgL23BsWOCVK
         Jq5PUuZHtAqpQ5TNonh9oHaBdxyWGQb3a1cckszDuorx56QaCDoqkWoyGLc05/dDJO5F
         1h7VAB8hV68rXGBnvE9bI9dMfohEHXdemoOk/IkftDlt3wgIg2CA3INQQzzJsi6s8jrq
         X5OA==
X-Forwarded-Encrypted: i=1; AFNElJ+SZODP8oeT51a8HzledQ66BMmNSwC3LwTefNZX0Ums+VzQxZa3NPKr2yeAXSK0OzXZKrbsYqx5Tkw7syoh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E0gn/kLi76NhNI6wJ4jQA/tNk/RWkfouGGkLMVKMaj0dKZOl
	7Q8hRjFwHnGkpaXHobok1mFoWry8SQ34+kqtRRcXbi2GEZW571OZp0QZ
X-Gm-Gg: AeBDiesBrRZ46q/n381naAwGKfefqwcQlUzc0DFYvh6jdjmPb3cVkCL9KJoMLZFbIi7
	WsZXRQnVN/0ShIgDJanrbNsULSNynSBPILj/bki09y8nOKXfCHnlpnOMWu6yN4x1hbVCVO5y4uh
	QYZgxm8C/Pu7Ly6mqfhqm83dotDLKKJspPH8ZNhxXIydaeDCMYHNY/E/sGY7LMwAVmeDMi7c3jG
	XYWxMYQwQuk3apaCNi8YNdsNl9kwI8dJPa4InAAGC9YUQqZiPhaLfBIqIPe+OkK6uNc8Sv85vui
	/FoSmwXdeQDDwFrfQ5UkI4B/le043FRyQtSkS6GNzaHYMzy6QsldjtfjddJpB29urezZYSEDA+A
	PNZGAwdlGtJtCr8ZrqJJt+F9cDe/pxheOd0+b0N5LeUBhX0y7BufLuIZT+4dFj4N1MRt61wb3p5
	Yd3r1iFKbaROM2Yx3Oim/pmlMDBUQQBwUQKXYZVb253acLevIt0HY6QA/NTddloRmyGXn+V8vL
X-Received: by 2002:a05:6830:82d1:b0:7dc:dd19:7f69 with SMTP id 46e09a7af769-7dee13b08e6mr2908812a34.17.1777766744839;
        Sat, 02 May 2026 17:05:44 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:33 -0600
Subject: [PATCH 2/5] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-2-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=CHcC16x2mZkLd9L6WSnN21EV5fptSGWQ+tM7q3yJFpjXLAwI5HVDVy3sD2GXtxkwS/MquW4pq
 9tslC9W6skxA/B/GQxi1A1G+gAdw3J1OCTEvOBGH/eoQDbxX3x07d+M
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

