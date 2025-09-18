Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F731AF2F
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226295; cv=none; b=lnotFxuUwZAyT2Dv2SU6/fSCYVErp8sORiutPtskyFc2c8wP5ZWSjcBMwubwjdVGFl51JlCZ2LKw0FKiJf0D7BlmMabkiiLn3r0BYfl8q3mjTDXntDFEOrfNiE0mtrF6hHN/czER28IAhhrtkkbhZ4jjki8jqWriPVCFUSm+6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226295; c=relaxed/simple;
	bh=rj45hXAuQZ5pTnKSdEd6dIpPHRwyw4ZKYgOKQst7uXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7VeU5CBqkeVg4djDt/fLENQQHTi3MCSRpsd9TjC0kZ+Z/qkTlc+yszHmkuhaJEHhDxRn8zfi2Wf6Hlk/nPYaLM22gLRzUX/i7nt7Af65fViTRAy7FN/g7nfenu64Uqimb6KIYISyw5uH6C8Mg7PyS0c96muC1B6M6Hi++6nG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdqocagf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdqocagf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-80e33b9e2d3so135269585a.2
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226292; x=1758831092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maHjhLKuxUFHWOYvJSC8J0S2l4myVpbFT09XkbzLKKs=;
        b=ZdqocagfsQol6m4QXLM2V8HOsZHq19flBcAbXHHYZab0NQBs7gkOwk+8tjSQhrKCqk
         +bD5d0INM556A0ybpzrZHL8axb0J+SEjYprGLXyJ9/OuzgOt7Qp2RyGnLb9JK4Lk+a0g
         xwoArrajBUriQnqumrcRNxI2s8IaZaome9gWwsvHNTGKL0iv7eDNnxkmOihRmsAg4fFD
         OYhf+UAv7mqmViYIWGSQu/wQVl1ePJLFkoWxHOUxI8hgxOj/IsR0yxv28AuI/RQvTZFx
         MaEzOjB6wlH+Um/Kv2qTqErpoIe7oFRYKBW5FM1BU8Tg53CW1DPXixsDiMLYVi1V0oDi
         /5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226292; x=1758831092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maHjhLKuxUFHWOYvJSC8J0S2l4myVpbFT09XkbzLKKs=;
        b=D3HLA1UyUHuq8QkQIrW+YRiZt+HmC7BkC+2O02JTccmgA+neQpZ8fpzs1yCHpDauwe
         NbpamuzeVxDOsy/p1wXKORfJgyKSLeULv8iasFJIS8eft2OwjHiybbWtAhzftYj81yEI
         H23HryVxe6JFKiRQqHc3omOqb/ayIZ2kPZt+e8CTt6eNpmjf3bTVIcNLxwQwlXBqj+jT
         tNhEjjLdtsogwiTRmaXFG68r0w1+s5YgJv9WaqCY1DivB9sdHVJXieWnBnvfEPJeABD/
         pzpl8izHTwGSbmL7ikexC/6d7Dpv6Pp9ZD45Jaq0EOURYEygswXEUMtEdepLoNQrcOXZ
         tcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbaS1Noop/NqRHWyEBX5BSm8F+yHYkEvzizmERSLivEJEz7Ltda5qbCwB/wNZO3oGbc/h3Ipv2SByb+avV@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBlDnE3S/wt/nyXXsszB7PEwsLNfQgFnfY9ZOdeXVIj5Muthp
	DQ6P7laweNrlPOJ0+SgGvuDReyo2+AHmY9yQlTd9dfdnSY+48ZgKZssn
X-Gm-Gg: ASbGnctUunzS84cWjrMCVVHbwcyvVtwBsBbmSixDaYM1WowekhBQ9vq0uoX6r6GSxt9
	ezPL4xkeIfrSkCU/NeaN7jQk/HthM+wKaYrVXmQ7YhvB+gc011pMvoBbybmsC3sP0pOrobwtnRR
	uOuf3U0Ah46GVjHSU36W48wih6WaVg1vsTh+yohS+lMY0ok4oYp6VIBpiBqCks8HKYBe/TAU0XT
	8rRgWrygG+qJQEstqBQCFU8mMP/ubEnrqZx1EKJRjeCwnJ02gTqynGRlxCGFOh8M0liXGsg2saf
	xJ/vTYs70Hf78X2gSY0zDYiWsRQ6oYkK9xmFpOLVVybbzXFBJtcsrA4+AvEaJPuGKaVHU4VhYnC
	OYxxobxqZl8y0VPuxXmmDN0m0QZxOrhDmw1l1+BiyOzxX
X-Google-Smtp-Source: AGHT+IFvvDp7Ar1qMFe3+qwycti8v0Ty9KaWDdNlFOgYJ/Wwcr8nmVuDHE8u7R3rXU5g7QLgSdPzbg==
X-Received: by 2002:a05:620a:460d:b0:82e:ce61:f840 with SMTP id af79cd13be357-83bafc2cd5amr86408285a.84.1758226292371;
        Thu, 18 Sep 2025 13:11:32 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:31 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 0/6] module: enable force unloading of modules that have crashed during init
Date: Thu, 18 Sep 2025 16:11:04 -0400
Message-ID: <20250918201109.24620-2-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running a module that encounters a fatal error during the initcall leaves
the module in a state where it cannot be forcefully unloaded since it is 
"being used" despite there being no reason it couldn't be unloaded. 
This means that unloading the crashed module requires rebooting.

This patch allows modules that have crashed during initialization to be
forcefully unloaded with CONFIG_MODULE_FORCE_UNLOAD enabled.


Here are the costs:
 - 2 extra pointers stored in struct module (if CONFIG_MODULE_FORCE_UNLOAD is enabled)
 - struct idempotent is allocated on heap instead of stack (regardless of config)
 
I had to make a design decision for cases where another (f)init_module is
waiting for the crashed module to finish and delete_module is called on it.

Here is an example of the behavior my patch causes:
> insmod crash.ko # insmod calls finit_module and crash.ko runs 0/0 in init
Segmentation Fault
> insmod crash.ko & # insmod will hang forever since it waits for cash.ko init to finish
> rmmod -f crash
[1]+  Exit 1                  insmod crash.ko
insmod: ERROR: could not insert module crash.ko: Device or resource busy

Here, anyone waiting for init to finish will receive -EBUSY upon removal. 
This is true for finit_module and init_module syscalls.
I chose -EBUSY since it means I don't need to modify module_patient_check_exists.
error -ECANCELED might work better

P.S. This is my first patch so I'm new to this.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
julian-lagattuta (6):
  module: store init_pid and idempotent in module
  module: detect if init crashed and unload
  module: move freeinit allocation to avoid memory leak
  module: move idempotent allocation to heap
  module: store and complete idempotent upon force unloading
  module: comment to describe a new codepath

 include/linux/module.h   |   4 ++
 kernel/module/internal.h |   3 ++
 kernel/module/main.c     | 112 +++++++++++++++++++++++++++++----------
 3 files changed, 92 insertions(+), 27 deletions(-)

-- 
2.45.2

