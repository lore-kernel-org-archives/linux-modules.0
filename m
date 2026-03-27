Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADE3CD8CC
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598465; cv=none; b=hvGgIiHN1QxIcuR2dRi2/CO3aDqEx1xyA5CL3TxvuAH3y7ObqmOBjcocL/mWbQ5XOiS044WxhjvAkGqVM7YxVS7Ic/13UpnKr2UIr2+GWNJrcD0KC7dr+pwNozUHqbd1nc2av0B70fasuVNd0iOIbYopovJ0D3XprIcGsoye9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598465; c=relaxed/simple;
	bh=W07Ke74xlJ9FViATMy7TNPyWUyJiXufTMF7faALrZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUA6sgekAvu+JzVQLV3nHthe80uXweJk8lp0AKne8gtnW+MK6Ab6GgJqGixcrHoLjaiBpOL4aIQpsXIcq6x6UACmfTPCOH/xZDlPVi/UFMlSBrFfWIYwNtWCu4ZCeRWBCr6WrBG2WaMLQfiffE/ckpXjvFLj4WmMG0ye4DqRgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DsoFy1hv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DsoFy1hv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso15536655e9.1
        for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598455; x=1775203255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdbZVRP/Ak929baCc2EeOgVlzDU6Wbl9p0jTnb7CIGk=;
        b=DsoFy1hvvwOnGNxyOoMVhMogo55oVsmvOCQ8pqd29ZIFMjIJJvycCTwApbMZKML4o9
         +ut3VtKxEa8U1RJYU5h6nurioOO5w/j2TQUhsj2bxVFxylgPf/y3xFBMp+i0IgfQX0C0
         h4ksXAKZfTL7XH7oWmDriWbYwJlPyU0xOiEr5mMUUEm5ac4Qr1wSqKGKfacOFjHNZnH6
         /f8ADqu4hdtXj0AcLu4CU6JXsNA6cmgDsT9DbtdRT54lK0mq73n3YI0AKCEbFExeiR/x
         voMZnX6r+BUs6sZNVeIiIoCFViH7Zr7gLNTZLgS6qOO0pITr/JZ09Xr8ffUMAGp9u93P
         Llow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598455; x=1775203255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdbZVRP/Ak929baCc2EeOgVlzDU6Wbl9p0jTnb7CIGk=;
        b=YUNRX2M9SpO8G2UEjtIJFDy0p7MdecWcUxl+B5+74uZIexxoiNL8T1agKQVRi6EHpd
         ywyN7BTgzFBrfo8gHTm33yK0bwPo19fY20HbSbYThrYU5/C/EqS1QTLj0os+it9AUSC/
         ZlgNRryKvF+US7GRVebn4YKAr9EZe9hJvZE+BYS+PS6RUfTmiSdvF+iEY6jalvgjHGL6
         r3+OxbyTPqOBnUd7GZlJvUe+oUxvT6oe5bYTub7aqcw0UfNnt5gkbsGwMbH6Sj682MrO
         biTuAjUicXK6CHAsmtkNldrJtzSf8NG8Pqv1DX3prRvHts2w5xJXEtpwtuAexhw3WFx8
         EeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKNSbI9R8nDSLEvqF5Mg77bVFoAKDFrt25U3D+qRYNt3BCBF3pUOofIE3siI392eQ+ZLwljmSgSOVJDY8p@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPv4n+r9BtxCFmke9Pcknc95+6tQA/9wh/Sc16zSjmBUjucAy
	BTHJdTEt7WWdBNYIT+jDcAIiBH0GtjEz43oVjaxmr57UAWAOdJCCBGeGPaSLEWyHtNc=
X-Gm-Gg: ATEYQzyPRXyg/cjFKUZlPDxpOAnbFDZmO82SpVW3F4P6VKWeNlU5fTvRZR86En+eM7l
	CKf7TJL+DaOM0hvftMnEgKvSh/M++2WNmK/B6b7GJnmKkvZg2exMKfxOUh3b18ksUR8P5wjH33c
	Sq4P/mlXydLsj+4ddvQYC/0Y6XtQFrcFDaXLHdfSesO0nSGho48e+2FLUZvAj6JFdOlv87lNDLt
	L5omzYBuR1tBnn9XZD94fahHRfb+mVWopQqC6ZMk2qpOE/q9Q1LNXlYyrg2jVBUzVQHL8g2WMoY
	Pm1ofG8N0BHZe/K4poiYFx1FKEh0nfcy6yHFWS5soWgVJ/DK1WIWcU5fZfVvuQV+qHyZyODrEv9
	kefQ1LaK5t9DOmxgAhEYxPmJDu0j9lwu5GaMqQIMLCnMDqCsq5+3eawTxS9H2sMJ4JNK3RrAdpe
	BS8oRjwptKuPDJnrg95PDJqI84TN8XKvEISZFnPDHb5QdvIFJoCTU=
X-Received: by 2002:a05:600c:8b6e:b0:487:716:2fa9 with SMTP id 5b1f17b1804b1-48727e883c4mr23399585e9.13.1774598455233;
        Fri, 27 Mar 2026 01:00:55 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fc4827sm12089735e9.11.2026.03.27.01.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:00:54 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-riscv@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] module: force sh_addr=0 for arch-specific sections
Date: Fri, 27 Mar 2026 08:58:59 +0100
Message-ID: <20260327080023.861105-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When linking modules with 'ld.bfd -r', sections defined without an address
inherit the location counter, resulting in non-zero sh_addr values in the
resulting .ko files. Relocatable objects are expected to have sh_addr=0 for
all sections. Non-zero addresses are confusing in this context, typically
worse compressible, and may cause tools to misbehave [1].

Joe Lawrence previously addressed the same issue in the main
scripts/module.lds.S file [2] and we discussed that the same fix should be
also applied to architecture-specific module sections. This series
implements these changes.

The series can later be merged through the modules tree, or individual
patches can be applied through the architecture-specific trees.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=33958
[2] https://lore.kernel.org/linux-modules/20260305015237.299727-1-joe.lawrence@redhat.com/

Petr Pavlu (4):
  module, arm: force sh_addr=0 for arch-specific sections
  module, arm64: force sh_addr=0 for arch-specific sections
  module, m68k: force sh_addr=0 for arch-specific sections
  module, riscv: force sh_addr=0 for arch-specific sections

 arch/arm/include/asm/module.lds.h   | 4 ++--
 arch/arm64/include/asm/module.lds.h | 4 ++--
 arch/m68k/include/asm/module.lds.h  | 2 +-
 arch/riscv/include/asm/module.lds.h | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.53.0

