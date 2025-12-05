Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87B33F385
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957162; cv=none; b=c3t2Or/dMRZ3j02NCHAjoUxSgqROsIuN5opy52m7dZtSZYeKeHXnKYWKHbvmfbppp8MlUrhm+xyoRC3fbNOdmG//ngs6rRKNKJyTJv/alZ6yVFSCoaT1IHXczurMxtpljp1baGkDOiIFvhnsyc4fj+WapVxSAvzTRgJ/27eLyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957162; c=relaxed/simple;
	bh=11kvn6R0v8rSS2QHl/rgXeoyj0GXSpWYWmX0nrph0+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqIvIHJ/62EyJtQNV1cWkW/3A/AiLfkIFcHZAin6XyUWocGI13YH+uObw2y8XK8Sjm5b2X9xXh28RUP4hgpIb87XhIYJSbfmL3MAhw4/ltx0emocjJbNsxvw2LGYC3mAnUWw5zzcGcTit7gULw0aDdml4WVFQsB+oze/eFlbF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKt+mVpp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKt+mVpp"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c2e5745bdso5454357b3.0
        for <linux-modules@vger.kernel.org>; Fri, 05 Dec 2025 09:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957159; x=1765561959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhdM+o1UMOQThbgKivVtaRHqRyLxM9uhOvolJtsLWEk=;
        b=dKt+mVppEaQGM0jOP5Ob9AaDf8ISohEhzW7EpI6ZBiDfJxrjg/l8PwFG/aH22Scdfr
         qZbx6glxlhZoE7kZjbjOq5mBUQ6XKDnCP7bwUhJIkvgrtrND1yf67nHyBy2JAsKLgGpw
         baW6Tyr+m5cyuIP5PJ29Vfy19wAFhe3SB8IU5nrTy8SL5XaZVQnC58VmsWK2aJjYtfIa
         qdt4tiUrx3iP+NRLuoK+L5tmIhdROBwV6TJx6VFmGU8DBcl3I8BF/jJcGYWn5HB7G8rK
         s0SK3/pNCDLSpn+qYjYcRnqdg28BAcVPp1NNNsLZyRHbRf4q40aM9d+Uw1Gj/7qU2N/R
         LYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957159; x=1765561959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhdM+o1UMOQThbgKivVtaRHqRyLxM9uhOvolJtsLWEk=;
        b=IgI97JDpzw/Tvo2HKKD9ToP8MdxfALml3xojh0NYxMdsRvJb5khuc/84eWFDiGDEik
         iDXAgcsAU+dFRihTTw1fWaT0wUsrlPLFG+mP1N7srKA9vK2u49bKoDC81p1KCYrPrjdo
         alI3XRCe6YjPz533xl+8p/dtk98pkRuKPnB3ZqHtop8sUBh14YLrvYw4MeA8jOkb7Ng0
         Wzi8LtIu8D9njEzPADh34yudgh6i4S9glor5oFM1zTPd4LR63ztaoIik2xKoEgUIn3rI
         GyyxP88R+pnJ50l9MULSX4KWUFbrN5g1Ejvw52wGzr0+muLHnK7tZSNRBCBr/Yc3OE/k
         iUoA==
X-Forwarded-Encrypted: i=1; AJvYcCXtbeG88M/YIYTa6K0RP4S4FxJWPbcucDb7+WxjUu+CuTYrrwsu+WhwBppKxjgzLmD4N+0ilss06ZXgr1fu@vger.kernel.org
X-Gm-Message-State: AOJu0YxxihWeEmpD4NCBjzZtXaAr4G9sjB4yGJINDxYWSt6mo4PatZAi
	W6RPEnKgHJ1GLmws5KrUxKnhp6JXHAeKu7UBcvZ/eaZt9MHbwFWRtnDw
X-Gm-Gg: ASbGncvuLwGt0HunB1PAr9WFJcJVIxXjFOb9mfaqwOLv4dxHpy0ZHLzsquw/7dYH83z
	SPqM3OifoQgJLUsdM5F68VWQ0MlOWIgu6ciL/5e3WzKwNrKm9Xa52oVrrLFEECAcswOWFm9dzlh
	XprLpWKNjcqCHr791kGlM0KhgeJxePe6d0UX6XhBjh2b0eiBYmMXbbpe6Wu6z9zuuST3k8JP/y0
	9XtuwqqPwFxqX3QEyAuby2Ms52P19PN5y7yY/9b8qYYQgfU0BBORHtNJOybefl8ryViPyGgfBid
	Ic6BDbdCJEvveaeoGXPBB4uhnLHSuVZWPb4NxRvvBWU4Oxa/wP/VHE/BtinWGNfCJljz8sSF8IH
	xh4W56BdmDlgPb/jNFyvBdgznsqENqLbHTixdfbmY38+xn1x3QRE7Q2m4Xlmg/p9NyBxBhpYfc0
	XiDvS5FA==
X-Google-Smtp-Source: AGHT+IGjlOLdXC97l6OEpoHY/ijeCRrrzo2vSMNi38e+iaXy3/qirDbODXQrNjFzrIZENzbiZevXPg==
X-Received: by 2002:a05:690c:4989:b0:787:ca87:595c with SMTP id 00721157ae682-78c18600ac5mr113255467b3.9.1764957158797;
        Fri, 05 Dec 2025 09:52:38 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4cffd8sm19112287b3.13.2025.12.05.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:38 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v3 0/4] Unload linux/kernel.h
Date: Fri,  5 Dec 2025 12:52:31 -0500
Message-ID: <20251205175237.242022-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h hosts declarations that can be placed better.

No major changes since v2. For testing details, see v2.

v1: https://lore.kernel.org/all/20251129195304.204082-1-yury.norov@gmail.com/
v2: https://lore.kernel.org/all/20251203162329.280182-1-yury.norov@gmail.com/
v3:
 - rename linux/tracing.h to linux/trace_printk.h (Steven);
 - cleanup headers better (Andy);

Yury Norov (NVIDIA) (4):
  kernel.h: drop STACK_MAGIC macro
  moduleparam: include required headers explicitly
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  tracing: move tracing declarations from kernel.h to a dedicated header

 Documentation/filesystems/sysfs.rst           |   2 +-
 .../drm/i915/gt/selftest_ring_submission.c    |   1 +
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 include/linux/kernel.h                        | 210 +-----------------
 include/linux/moduleparam.h                   |   7 +-
 include/linux/sysfs.h                         |  13 ++
 include/linux/trace_printk.h                  | 205 +++++++++++++++++
 7 files changed, 229 insertions(+), 211 deletions(-)
 create mode 100644 include/linux/trace_printk.h

-- 
2.43.0

