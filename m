Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076745518E
	for <linux-modules@vger.kernel.org>; Fri, 21 Aug 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304678; cv=none; b=r+4S3BWnpP8MIWgkLZTkoc12jANBa87jHbpXCfCaasjDBlpoLUiy9d+4pYEuH8tnaMgbYOzh1Wl7IhLs780ezBY3c73j7e5HEPuR4EXWrTpExMGHLbxRZxsgT68013YNAMt/ZcGGLpL7UeadEtRyEkpcNPlUfC7UoWcJLwkHysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304678; c=relaxed/simple;
	bh=RYG4RcID+aICKl11OaY8yt3uAJ2ri/2flmuqma51gP8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Fb5rPQQv7MpR/csKNvPr361iUElXJzS8o1BvSkkGGJe7iT0kEsXvRlqPiO13HcH8KurawHnSrYOseprLxW4YL+AgS/rDyHnaPAwqqIKXtroyLFXTSD6OTakniIuIrmMXZwK3PzW5+hvaC/6ot/bpdoVZGQ3bjQzSV9w3TPw590Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UQO85aG2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UQO85aG2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2020421077so135132766b.3
        for <linux-modules@vger.kernel.org>; Fri, 21 Aug 2026 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787304666; x=1787909466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ohgaOyTTAZMxpB4aND6CedHaGkuOZs2IJZJVdF71DPQ=;
        b=UQO85aG2toGCH265f1QblMeRTnldu/ed4AGN8ZYl5irPhf/enx83nHh5CcbkJUgrBy
         87ZGlMM+Id0O5OAplNn6T+TmXb7rpMAklbKfEDp0oU5WpNawSR0rW2/zlvomYlT2jEY5
         YAmMtds/qgb8dfoSxpF4U0Dnn3TwKtq9a6sRNHc+n5y1f6ZhOpXEfjgHvTK8NO1zMSue
         CwtnXn1oMLRWeeInaH/7fpHt9am7QKEqIG+OaiZ+0/tKDTRCjePXWFuCqSK6F2X/V3qo
         jCrRufA4Kj+OOtSKt15vZhssrmktxjj/V4et0vUi7FMuqH8n1zXYq0cl6D4NaGPFVS0S
         lBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304666; x=1787909466;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohgaOyTTAZMxpB4aND6CedHaGkuOZs2IJZJVdF71DPQ=;
        b=YtyawEJQFScDDVA4gyeSpQ/WRVLrYfaWVGlXe77a5IgP1+av/b7hkldzafLpzEDdCI
         akvk9d7l9mSEKDnJp1N846OpP9fFE65rh+bLHM+Oapz0JsMpvRTaOukAkPk21MvLFxhz
         Q17l4JEPswgLfb9VFtCeI9E9/z4Vl6yy8vr/PJJi+YPTyJe/q7eC9of77XD21MVDYY9t
         eyMjuZtRLxGXtYvT8w9oYDK+Web1NICLsBb++r05rGI5xFtanz+4/hiUte51DheJu67o
         PbyEJzY/lr7DIlNvRG6OG5Kc/hjvcJf124lSuZ04HGr33VJv59kPYRMTpmZDWETQlD59
         3SqA==
X-Forwarded-Encrypted: i=1; AHgh+RoANYbq3ekq9qFBA41hD9CEoN4vSlLgV/0ALF5Q2weU+m2iOIIZ9S4uIetOyxMjoFJJthodVAozCbLmXUt5@vger.kernel.org
X-Gm-Message-State: AFuF++khFS7qfEKneQ13+Bv3xZinGC1/5qdlXl5g+IdFAafbOttezGcG
	ST5btq4ihjjpOcnCXHgw7X6eaUv4V4We4wWT+8GSD+NTE7rUqF5FCdhAtiqu0LJyioE=
X-Gm-Gg: AR+sD10AzemD8vm3nsSsB+yuf4p0j+skpYL0stQZukm22sAwHeLOTSZEpiw0+MFBLdl
	Ml8/OPoxQTCMen58dk0SgONhA9+RZqNH0eiyQ7IBxJfMHB6UBvZwBDwrRzypGLTDFkjVRcwDcXj
	HoIz5hz2KWxtB4x+ADzDxE71edk2d9+6wfOMurooaObQ7ZfONC1pFZPscvFKnVz3dgwavKjMYIe
	uGgc8VUkswU77FDQIlTaZn1clX/nFfhc0je+zxCVDU+l3ivRHSAoQGPwSwxQdv4zoAxllTq37fC
	OHM+RL8wkkSM+zwzcsUcb7PUgHX33cmgVD0Fz7c96S1SDEfDHMGqBpBgppmhJLyCFzNR1MwwZvy
	iYChnSsJFDVFhqvPxd29qY58VrHgtUbOIVm0iK02bHfx6lGpfd8DpFCMlBCkz7XK89KFA9H3iLe
	D7PzYSHUAPsWn76+5IiCKC1c6OxaLc1fFoyv3op1lXwnvXog2kY+ZS8i96JzjKN1sBWUlBTfOPU
	O5VBrYa95DBx8M9t6/p4JTP
X-Received: by 2002:a17:907:6b0d:b0:c24:6505:8f66 with SMTP id a640c23a62f3a-c246a693337mr601093466b.13.1787304665835;
        Fri, 21 Aug 2026 02:31:05 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e04b5sm397477866b.5.2026.08.21.02.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 02:31:05 -0700 (PDT)
Message-ID: <a0068317-feb6-4152-beff-8a120cee2d51@suse.com>
Date: Fri, 21 Aug 2026 11:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>,
 Jiacheng Yu <yujiacheng3@huawei.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Stanislaw Gruszka <stf_xl@wp.pl>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, Wenzhao Liao <wenzhaoliao@ruc.edu.cn>,
 Zenghui Yu <zenghui.yu@linux.dev>
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules changes for v7.3-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-7.3-rc1

for you to fetch changes up to 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae:

  params: fix charp corruption on allocation failure (2026-08-06 16:44:48 +0200)

----------------------------------------------------------------
Modules changes for 7.3-rc1

- Remove unnecessary module::args. Nowadays, no parameter-handling code
  points into the module::args buffer. The last user of module::args in
  xtensa/simdisk is updated and the data is then removed.

- Add Rust support for boolean parameters. This will initially be used by
  the Rust null block driver.

- Fix clearing the current charp parameter value when setting a new one
  fails due to an allocation failure.

- Improve the debugging code for kmod (request_module()) duplicates. Fix
  a potential use-after-free when waiting on a duplicate request and make
  several general improvements to the code.

- Fix the symbol size returned when looking up a data symbol through
  kallsyms.

- The remaining changes are smaller fixes and cleanups.

----------------------------------------------------------------
Andreas Hindborg (1):
      rust: module_param: return value by copy from `value`

Jiacheng Yu (1):
      params: fix charp corruption on allocation failure

Naveen Kumar Chaudhary (2):
      module: use strscpy() to copy module names in stats and dup tracking
      module: procfs: use matching type for accumulator in module_total_size()

Petr Pavlu (9):
      module: Remove unused DISCARD_EH_FRAME definition from module.lds.S
      xtensa/simdisk: Avoid referring to module::args
      module: Remove unnecessary module::args
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling
      module/dups: Avoid unnecessary kmod_dup_req allocations
      module/dups: Use scope-based cleanup helpers
      module/dups: Use strcmp() to compare module names
      module/dups: Clean up includes

Stanislaw Gruszka (1):
      module/kallsyms: fix nextval for data symbol lookup

Thiébaud Weksteen (1):
      module: validate string table section types

Wenzhao Liao (1):
      rust: module_param: support bool parameters

Zenghui Yu (1):
      params: fix path of /sys/module/XYZ/parameters/ in comment

 arch/xtensa/platforms/iss/simdisk.c |  38 ++++++--
 include/linux/module.h              |   4 -
 kernel/module/dups.c                | 169 ++++++++++++++++--------------------
 kernel/module/kallsyms.c            |  24 +++--
 kernel/module/main.c                |  29 +++++--
 kernel/module/procfs.c              |   2 +-
 kernel/module/stats.c               |   2 +-
 kernel/params.c                     |  16 ++--
 rust/kernel/module_param.rs         |  27 +++++-
 rust/macros/lib.rs                  |   1 +
 rust/macros/module.rs               |   1 +
 samples/rust/rust_minimal.rs        |  10 ++-
 scripts/module.lds.S                |   5 --
 13 files changed, 194 insertions(+), 134 deletions(-)
