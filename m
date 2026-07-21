Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6287364E85
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639573; cv=none; b=mj9ZxCUClvfnccSw609ZcKgJihcSc7U/pDTQWDR4py4p2I5JrCd2ke2sSyFlxQBROircXbeKrW0Fw8CWDz1N4IGfCxqOyyFzbY8Ttcir8mVNWKpIdVFuwkHAnA55rezJt4b0PowS7iiQnL2sRKYQBqcmYRp2wx5Llav6R9qmxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639573; c=relaxed/simple;
	bh=roviBJb1B7iQhUITwXosnTCAe4xvx3i/dIY5PCDwenw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m606iEXWER+LemYj6iLAvfwWGRqd9SXx/nbPrafkB4JbKXFMIlCkPF5224NVNp5g8uTE6pNBgsZ/cY7SNcffu5P6qiOHR29Ctt1OQTyi3JS+GBxWH7QmhZ7TlRb0Kw4qnTU//tzuHGsXXxnbD8JrCBrqueGoqzD92mxsMwXAQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LoGxvBpD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LoGxvBpD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso849097f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639565; x=1785244365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=LoGxvBpDEU586mANHKg0AlOVLSwjxUwcerLWqBCuDTqB3BKr12xDPuAeaITf0OJ5u7
         pW5MXZkNE0Spz9kUiB9YFRowyZ0wzFTcuAQcWOmZNSNocM1lGunteIJ6qMNsP+7LQHCn
         K9g4hWqiodIzksvb86yTlUcAOgIE59cm3keL138dQdp2+Aqm72Oe/K9ovJombOHk9b77
         q7K21gZoQ5BwAZI8RwxdUwRFZcTCvQniV3IZouqx83co77jWHl0m4ZIhqH83wfbTdKJo
         gJdyjf/44/40tPfp4ckSZbjo5gpkBplWyQ2sI3AVC3OjkfeUBdeeMBulLolpi/ubh9oF
         H8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639565; x=1785244365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=nHsqZQG2Lm5fWNNr3yRcIoALbuZtwz/u4M2USxMbSnJiNOZbkxGst+JQyAzwJuRVIG
         zylnFzZPTIWvD+5wj2uVbah4dL+mEO6BYMf7rAMCq2VxBfBn1Pk98uR8/tP7LLkmgQAF
         hYYBKeJxtRiOxyOxpGmtinpvVEWbfkat9+kFAKGXfvfWbG7MOgZ97Jue/hrcGvbyCaEa
         1GJVRUcRhSIGIvLE4t9vJ4pZ6WmEfQnUa7F6a+0jVKA/lTnHF/yk9m/yMZQbfbwUuWLA
         zIq4LC7bTtwft+BxZPxmjPdvWxSau0IHEfdPL8bYt6Ji/jeKHtc7ZJ3PIKwJgY9w3D7/
         PHJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpi+gIcJlC7ydpBgIg5yULQCHrY3PsxHqKNWpxOoPp848lbXGVXCjwqz2NDGewMWlVSOxP3aN94sb+OO4FR@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkIASrtuF5XMaXr7vgxXaNI65rDkoyUzf/UVHGpezF4s9uzlS
	BclW2x9Wx1cqLRAb1si4n5Xud9pAAt+vy1HLAmz3p5q5mE5+1ZtOLAfN54H6KrM9+k0=
X-Gm-Gg: AR+sD12YOFv/KX8EWngibeOxAEzAXmObnOJcS/spL8Csm1YW9ZMhgYpnS+5IX6B0901
	Pgja3RbvBvRFBaM+76t5QcqzfAnXwxue4OItVVq6pFx2m2gFDCd3gpuiGm2MGM3G+ejYK+i1q3B
	c9ocEDuBwnDDCDOdiZF4wF9X4SDDAT3JOBJJfq85jJPK5hpWqABksBAscjbm/xOYmovVV380E4L
	CpTQFwezEmu41ohhSuEgLsB6XHR6FwYUiE81vjwtc8udkpY+YmpGMOfGFZZBkGJYnvKbH3Ypn7h
	GVec9cg3+S1Oc2rtW2ly9Bt1MPo5w726EpL5qu96d+/wmd6xaBXcIVYq7CNsr9GFiG0+z18FaGK
	QwWIrYyshQULHabB/45eBG/tABbuROc7aPJ7pvOrMg9uo/rieyquv7EUuxDTmCV9E7KwawEE2kg
	==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680;
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
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
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0

