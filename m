Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEA3A1CD
	for <linux-modules@vger.kernel.org>; Mon,  2 Sep 2024 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252094; cv=none; b=dkXUePBDCfbFcRq63x4ODZWWjIoZwkL8ZxJOW0K0Izvp4n4r9KG2h0cGKtuMJNENNQ0RV/KX8eyVyGJxFSAQzt8PFcBAbAR39Nyw7i3qf8iXb3GnQKrwf/qDFNymA6lCTy/dt9NKIp+KUdJdUiPz4CvZwVqNjP4ncPz7duQpVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252094; c=relaxed/simple;
	bh=2yYesrk2XeOkiLpyoJrRc9CQY3G+vSCbxn6itbaapxA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FLEfT7kQpZiVfnOGDdePLgguJQlzhypF/O03zC05pifFNdnb+/iKYrobDchOz+Xi3oRtDa/A8MhpJhY/F9BSrNMKI880aWEIFOglaBGSOfAAwgQZnfJweCg+/cSX9RMJ21xVCW32rigCwvByjV79LP8QRVEnkXJkHUNTCS/86z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9fHg23Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9fHg23Q"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e116c697904so7977771276.1
        for <linux-modules@vger.kernel.org>; Sun, 01 Sep 2024 21:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252092; x=1725856892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+xLud21hrQ5yA1EN2qeiMEzMSrTdr6OveRNrXJfwOw=;
        b=a9fHg23QJi6LOx82/+bhdT9Y/6bH+3lzQCHICw7HOSPphcTqUmAzb/G3AV/q9lS4aA
         MNR2FpjEqTBw+trO9720V3NM8jUTghoMcjjVtXdgqiV2zn5T4SYyJghT/46BTcEU/1LP
         q1K7l0LEbZlCevs+9eebA80Nl7rL6JS1/XpKYVFfylpZa/49DqimTMYLNXNc2ddaAWPZ
         n1DfAuJxcVcXS8Rh6D0UVc7UFmIPOL6ENewmCqPe34XL6tPsMKS8teutjftyzezrKcLD
         hEEXvTbnIR+E0LgffE1aLNf4xqHHoksfa3uHkppHxnscjHVF/1bUqq52Ibox9OSb7wgc
         1Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252092; x=1725856892;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+xLud21hrQ5yA1EN2qeiMEzMSrTdr6OveRNrXJfwOw=;
        b=ZEL8U2nlkLH1f3LUB4cibtbnbEKc3/4DCwmMSougrgiU/Sz3adLi7MJ29CHb9nHUA5
         FWGRIvmMZm+dSqZq4izW7gzGgWMZUGcIFZ18xjtBOVKnduJMVaY5dJdIm7BIk/SyRma3
         CPi9frJBczNCU9gS/XA9sPvpOysKvZvoVn03sfWmBVcWOiln4S29ytWMJ6B5yC2Le9sp
         4LS3ElW9YG10i8DNofPe8+TAOw4eIiDpbkcpCaxcJuVJ5uvjO6Y+Pz+8VtnfYlc0WmGd
         nZeKAsEzGRnDl6ig2uSs20JMpgmTOZuLbP8XR2sit6V/ioDMHz9Mzy6uotFZZ/d9fCau
         K9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWzTJeUejFPQ9RJugZt6QzDnHf8Cwh+0SY7m067FN0Zyg0pF1+kTVWjrMEJzsaWrQgeQpwOCx8p2ibyVg2v@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLkbSP+E8o6R8hz0qGAMwLqHrffRzDgDYneET73jfkTQIO0gk
	tiAFuJxYxEJOzqnjEgFsuUw80iH/YeTL8s3ER4VrCJ01NuuRwAGA/teZyI1nVLDuDw+hqOEl7/u
	6nw==
X-Google-Smtp-Source: AGHT+IEtE0kPr6IIFRldaKi06F+5QIrTC4yNkT2oW719Q3CsdKB0l7HveLeFNrmbQ3s+nnJWshQtc5hKBEM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a25:99c3:0:b0:e0e:87f7:f6d3 with SMTP id
 3f1490d57ef6-e1a7a1cfec1mr370503276.11.1725252092109; Sun, 01 Sep 2024
 21:41:32 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-1-surenb@google.com>
Subject: [PATCH v2 0/6] page allocation tag compression
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

This patchset implements several improvements:
1. Gracefully handles module unloading while there are used allocations
allocated from that module;
2. Provides an option to reduce memory overhead from storing page
allocation references by indexing allocation tags;
3. Provides an option to store page allocation tag references in the
page flags, removing dependency on page extensions and eliminating the
memory overhead from storing page allocation references (~0.2% of total
system memory).
4. Improves page allocation performance when CONFIG_MEM_ALLOC_PROFILING
is enabled by eliminating page extension lookup. Page allocation
performance overhead is reduced from 14% to 5.5%.

Patch #1 introduces mas_for_each_rev() helper function.

Patch #2 copies module tags into virtually contiguous memory which
serves two purposes:
- Lets us deal with the situation when module is unloaded while there
are still live allocations from that module. Since we are using a copy
version of the tags we can safely unload the module. Space and gaps in
this contiguous memory are managed using a maple tree.
- Enables simple indexing of the tags in the later patches.

Preallocated virtually contiguous memory size can be configured using
max_module_alloc_tags kernel parameter.

Patch #3 is a code cleanup to simplify later changes.

Patch #4 abstracts page allocation tag reference to simplify later
changes.

Patch #5 lets us control page allocation tag reference sizes and
introduces tag indexing.

Patch #6 adds a config to store page allocation tag references inside
page flags if they fit.

Patchset applies to mm-unstable.

Changes since v1 [1]:
- introduced mas_for_each_rev() and use it, per Liam Howlett
- use advanced maple_tree API to minimize lookups, per Liam Howlett
- fixed CONFIG_MODULES=n configuration build, per kernel test robot

[1] https://lore.kernel.org/all/20240819151512.2363698-1-surenb@google.com/

Suren Baghdasaryan (6):
  maple_tree: add mas_for_each_rev() helper
  alloc_tag: load module tags into separate continuous memory
  alloc_tag: eliminate alloc_tag_ref_set
  alloc_tag: introduce pgalloc_tag_ref to abstract page tag references
  alloc_tag: make page allocation tag reference size configurable
  alloc_tag: config to store page allocation tag refs in page flags

 .../admin-guide/kernel-parameters.txt         |   4 +
 include/asm-generic/codetag.lds.h             |  19 ++
 include/linux/alloc_tag.h                     |  46 ++-
 include/linux/codetag.h                       |  40 ++-
 include/linux/maple_tree.h                    |  14 +
 include/linux/mmzone.h                        |   3 +
 include/linux/page-flags-layout.h             |  10 +-
 include/linux/pgalloc_tag.h                   | 287 +++++++++++++---
 kernel/module/main.c                          |  67 ++--
 lib/Kconfig.debug                             |  36 +-
 lib/alloc_tag.c                               | 321 ++++++++++++++++--
 lib/codetag.c                                 | 104 +++++-
 mm/mm_init.c                                  |   1 +
 mm/page_ext.c                                 |   2 +-
 scripts/module.lds.S                          |   5 +-
 15 files changed, 826 insertions(+), 133 deletions(-)


base-commit: 18d35b7e30d5a217ff1cc976bb819e1aa2873301
-- 
2.46.0.469.g59c65b2a67-goog

