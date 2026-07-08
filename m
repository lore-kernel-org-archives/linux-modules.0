Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539893749F1
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525567; cv=none; b=Bj0JGib5SoaTpYh1cRlX1ZqOBGYBKtxYeBsIsWVgnZqsJYS+WC3DnIirQAWZkNBIEeHSu3erY9/GJyY3+GweAN+YfP3L0Txq3ohO1B376RolGS+GgFq67kTfOm9TsgrdqJtyG+isY/FFRDfaQ822BMQVMivRDm5vcbR9KZE8BEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525567; c=relaxed/simple;
	bh=9vHkvbT9qGw6XnwnbsV8mVwKGJQJ6h+q3CIzqn5nO9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/7MOW/1HYmjDdAduTCXjTkQ2muehTJtSkWiaizbP2RGH5gvboM7LDTPXhSF4j6dZsUxXNEj3HUBsePVhW3/UyAwiF+SxbbGtL5Lg94eLv9v3Q4iAdKnJFiSC0d4E+mfjry5neFQU0U0GEFBxlhrSWIGnLrzIv/SbdMTvpycEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Okh+BFe4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Okh+BFe4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720d22c94aso808403f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525561; x=1784130361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=Okh+BFe4TBJzNUXNKVWkbJcoBYMQoJbVgQgU8zXnxG0Le4ufb2U97eGqKaKpJO8LTq
         c/AfApu3CyNCB27ERbeBeTtDe6fOJa9y3HCWmu11zh0/0kK+bBc4x45UpJCP9reoh106
         1FiaiF/LGDBCz7F4JFn6xIwfc0tyzbjl5b37+UIt2HaDr5QtlzaVFH5TdTnqH3M4NUIP
         z8zJT4neZQ9kJ3yhbvrlYIhOgcwuTbGM79DK2GkwEntXsARQxv7yxPmYK787do6zVwn+
         UF79OD2SbOy4x53LbQqLVfkBNRPgiLyE9ehLP/udTeAye775vSdz4qHlK3iQdtvm9ETB
         h4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525561; x=1784130361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=kZN82uXzKUsqHQNnhya+k/En9CVAiLAJSGiQJi8CBNrhYVWKyAMnrXZwZHqXadJsJ3
         4knc/q3QF7z0MFYq/KnienKR+L7Y+DZRVYBqj411VRRamouMsiSUCJBjtezFFRA0SKDD
         i0BgwLEu7hR7ZrVUkcOiN6+tp73UByZhfoxHMuL0WX6b+c6K1rMtjRd95h0sj6Mehl89
         OkI/fyZNK/vsddXI/y3cLCfjKcMm3lH7LyJjfMk2Eb1aNWxAOEf7qZskDjfFTUPYkrQ7
         mTO8Ek0v8uh+tUdYXWfWt78RL9JS++ABeyjNaIhf0Fm75neJL5WNBnKgLYvNcAx70OCQ
         QqjA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5Gr/0ubMhj4EVFDU+m9vSt6iOacwm4NCfZMyJBbVtactNC6oRzOQn9XrBuesvc0Z+TnC00sIR6F1PNlCh@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+6qV/BPWyHcjDOoZEp1ld2w6Nyk03g9uaH+Hvve8vE6SnYQm
	TCLaT6tjYC5V5xQyEqgj4IBW5wN7fA8vK9P4oUHeNxDuRMR2MZekkvcr6DH+QTKaPDI=
X-Gm-Gg: AfdE7cm+9Xo3+IjKXvgHccdsbYqDkXa9E7Cplxl4NZxmv2aKiC67BjHI8hIg9/5QCql
	UJppJO84wnoaP6MOmDDZ9JxadYM3XWM9hUKZ1vJ+cSqz8LQhe9hDgIQ3376IjtCFg/kfYBwjjKz
	jRgLlrocdbZVtb/ufvOr1+Xy7pBCqd9F7RJuT3FkRH1jGflYoM61ZiM83IcbgUFVnTQXw7CmCag
	pvM+OpLHFTMGi3H4YrdaVPyRISpfIfVn+f5tQsvFup2iC2VO6EckIiq+brbFPPDl0ZnGdAmXPzD
	NQ5i0alL0xyR7vsColv6rwOmJZ6qWfX/XZwVbbeVlvG8VTvLOqDn8E/zDXL9bspp9havUC6BXkD
	2KaoBQ+aofBOa6PH1ZAbqdK8MhkHy+ujL92uz/qMRM6JtRrm6G3Z97zmhQXXqKDAygBzZxGzK1F
	0Voo6FYRJcYDe+nGuZlPODnNaMC5tCF4eDmix+tem8
X-Received: by 2002:a05:6000:4304:b0:46d:55a5:8ec5 with SMTP id ffacd0b85a97d-47df078bbffmr3378920f8f.33.1783525561596;
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:28 +0200
Message-ID: <20260708154510.6794-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Then clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

Apologies for the wide distribution.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Petr Pavlu (2):
  umh, treewide: Explicitly include linux/umh.h where needed
  module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  1 +
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 21 files changed, 22 insertions(+), 22 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

