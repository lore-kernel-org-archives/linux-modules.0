Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2621D63DF
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034223; cv=none; b=WOOU2lrwK6rykYUub5uku+zO4wiuNL8Yj/MqMZC5x6mu9rb7/Q8lWZ5VOYfZg8930pQy61fCT4ecL64y6K9C0Pwe7QwIlQEn58dvoXgrkvh2qI0IjMJw7Smh+d4fSwxtRjXDgGH4D1S7rVSw+Ew+VDYQDI5HW+JdyVwVnaODeeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034223; c=relaxed/simple;
	bh=QHhoXvpDEQPD/TLcchSrrWPbQthnrEyocMzfS0P9NlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qEWFd4M7VCj7bJIXo3qIPKALGR7jutgQJnWH/tiS7iXQNEi0X7a602ilxLtREsVHr837I3t23YY2D4RhzTy4R1DTeSxjqA4mkY0BP0nWQbZGunHSSR9hrB9fj9T8qcWD3AZlc4lt0Ue7nop95H4wfNWf1px7+DE3mEs1X5jB7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=At/WHyQB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At/WHyQB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso8158431276.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034221; x=1729639021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbEG7McUi9uEsl34Zx+GKrR9c4aF7zdcdcYg+Y9woE=;
        b=At/WHyQB2iNFrmHLOvaUVcnNycV2VXevkFrNgr0tmzO8PngCWPd9pRFcJPNc1Q1nvQ
         DgK84P0q9RB1IAk+PSLfeTCiuiZvE6iQuqsbj4t/C8bqEFzgvqYHJszicV7VH4okcTcy
         S29ReuJ6ffcAuCL/y7qmwYjJIV/Ys4oKpBYOm4zdd444THXc6V4dqoXEzLGZOvpe7a7o
         J8goC0c4AYBmOf0nZILXSTInL+bAzXvvQowkteJNxGC6He1AJIJqLIo1ZXJLeK2zKhI2
         EUw5+vuyM//OQ8Yu2KMFkSsydbyeu16INNfxOiyJTvIPkUQaa5cK1Bp5b5sAs63BTLqF
         lRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034221; x=1729639021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbEG7McUi9uEsl34Zx+GKrR9c4aF7zdcdcYg+Y9woE=;
        b=iewt6QSuCiXVf2I3jZ9UB/cELdZUGpzVdOEXFjw47+2VZKDM1kaHBaQzlJFZJiCRzX
         qMsiP2NUb9A+bKVu3DzCcaxMkxcIF4yXBqJy12jdKNZiQEa4qSzzwnJmtf0Ckq1SLm7e
         BwsRmL1ovwQg396cccns5B5CrhWl0Pl4+6vTqx0eGEFahutupl8XERveT1ai8L37IMS7
         M4niapIe7rrZMTpZfRUHatP/OEqX+zOTWoNi+flXJcIy1s+bGhQIQm+MOCcJT+s3cCFM
         qMcBynkwnvdwV3S3XzvMQCAUaQEkQYPMUDBbvBo/vNmMXG8gWBWLujJxih+sscNliTD3
         JFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1hSCO2zfL3TUcDyl0swRwjHajaF8xgPF/eJEU2/YGI5K+G8vYlc5RNxMzgj6w9ctV06UeW2xfCikjlwmF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxa8hNDAKRMoWTUF0H+kBpRYr9y0peF0YQfSnzTB3qpG3pzeew
	9t2+5jCNltUozQ4M4m+6l/kpZ6tFKLg4DLoWjd17UW8+Agack/kpyEHExGbfsvBVELe2+WyeF1v
	O5lSqkQ==
X-Google-Smtp-Source: AGHT+IFPXzBe3tq4UEclYkB5CjDIeF4FAjlDz1DojdfYJQwU20ut08n6Uq7PA2tBHvy9wJlNUFsUH1mxlBeM
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ad60:0:b0:e16:6771:a299 with SMTP id
 3f1490d57ef6-e29786b577amr950276.11.1729034220838; Tue, 15 Oct 2024 16:17:00
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:35 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-2-mmaurer@google.com>
Subject: [PATCH 01/12] module: Take const arg in validate_section_offset
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ef54733bd7d2..1ed1d1bf1416 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1678,7 +1678,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.47.0.rc1.288.g06298d1525-goog

