Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D882E7F30
	for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445989; cv=none; b=fs87A62Sw5E1hFzHNQ+QAm5GaouRvyaPaJzCUH0ZVF4R/8BFY9P8o0tOJ+iJ8AtxeJ9ZXp7VVhEyT1CunJJJ5casYPUnqM2H4q6ezoHz3ESYzD6nFDnIagK9KR45AfAj+Urw4ya6ItG5GqTtZAb0iT3gk3he0+O6VH66yiOeVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445989; c=relaxed/simple;
	bh=U6wVjDQqWIkEPY9m3/jjaLkHW2qb9EnJS9XX+Cslv54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMhJOUN6JLgTNhgf6AvxWtmLkjAgPaLYbpbPltUAHYeYxcok7zCZabj7ABZgQBq47f4hC32gve5iE5wnoKnOvxgh8SvxErbsWHwa7BMdefnZ9jtT3LmgnJ6grhq0yZUkpB5H7RVfGCmtlVz8axPQO5GDzYeoURFjdG9ohbXrfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoxjn+d5; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoxjn+d5"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640f88b8613so2045687d50.2
        for <linux-modules@vger.kernel.org>; Sat, 29 Nov 2025 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445986; x=1765050786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMtAFmfUFSqT7Mio9YvaV3lvjHpX+ONaRINwsv8b7ko=;
        b=Hoxjn+d5lQ+osEJtdy81Bdv7RMu4hA2RK5i5Y+W3oyzginhMEjFS6/pCG7jd3KNj6i
         NgPB2Y2agsqDx6g0jkRMSm3jdxWYLUM0UIsOmOGoHCZLoF6aKQ3PnRsKdLokW50Nfy3n
         gk51VQKg7Ybo/izPTilrxXieWKJGb5pixFcz+1SwqrkynepDpkqqqj68UJuK1nYonZvr
         PHqtXNUr1mkPYvPQQHgG+FdfYkuR4zSfnKhk33uBTXSJb6YIqJvU9Fg5R9dhJSRzDYuc
         HNILPUUBmI9Fhg/AjvwUlsFs+O2SHuQ9IHQ9vxPPHqNe4zFlwX96+Kco8FWP8QImFxkM
         M0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445986; x=1765050786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMtAFmfUFSqT7Mio9YvaV3lvjHpX+ONaRINwsv8b7ko=;
        b=vyZpH7MMZEG6ZGpJ4eAOpeBfQhC1yM9Qoy9A29CJPreK4s1BjvYFNzswLQV52Pn2tL
         f3lDlP06HppH1/6b277plxy50/a2eoKZmTxb67fJ9jKCled2oRe3rW04PY1PrshuT6XW
         ygcPMDqOMC1HQ68ywwsNJ4bJypl9yH6k2YidfO9t1GA5JsExqVSWR6wfUPaNuipb67H9
         jACprRv47eNDSrOQZY/skL0N3yXAIlGgFLRxZOawMOO+WIYE0Xj94RtU1D7qSwQ61DXy
         9Lq/WUh+z30gWyt2VoBy5c3PENFCqKrHSd8z4D6m28Qh1qGfUG4Fy/Ih9WKXPZhmskCq
         81eA==
X-Forwarded-Encrypted: i=1; AJvYcCU2rUtGEMF49uMtcuitHOKALuBpu39F2q35VWLN1Uzx7U9jAzpAvaCOwqstoXN9/NR1NK7JdG2XV6hVJKZP@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDhZHUod50/9yjSr+tQff3IXFomkiGXEG9LzcRZKtuavr+ZTS
	yg/bseiKZegfEYyOsTUPdmRXqT5HPfL0zMziLD/bbp9wl45uvvrhOuui
X-Gm-Gg: ASbGncsdqbgHva+GEyepBfvoEdqU2i+yk9YqgW2E+g5NIQ3EurqcT0NOwaCwUqWBU01
	mrd16jzhQ8f+MYggWSqqBYGLj8yJjSZuCr0SFitfCIy5OsttqLCZgTbCLORPV/w3VzOb81Y1o4B
	0oC8iNMYI3DJHK9R+wv5Xz1SAOkU9j0/y47lSKYIYeULPfg1fvo8bVS9W1T4YxhviI1EkmRO22F
	eSEpbRbdmQPti6B6HTMUZWrC/Jcu73o95g6wbf+19WMQVe7Bdu6Dai7WSSy4nzIRntvWUAbJ+TN
	CqnGOtAwBsjiFZNM0k8IqVOk1k5asgVUNWpIm8rQrLwlCqFD7e7jJMil+NHKGmrPsBLopcBo5rh
	rpeIWqv/hQijwdhTWCL8Vu+WSmuEzKvWLvhoyPux4oDWhGMb8gFLh215RJZoTrMtEbZ4icjpLVI
	H6Sq/EQ9I=
X-Google-Smtp-Source: AGHT+IFe8Y0GMh+6LMlCZSdBuNKhw5C68QDt9RitlP5LR9LIFpydTgLo1EIGXwaP+uPjQ4SltW6e2g==
X-Received: by 2002:a53:c052:0:20b0:63f:b922:ed79 with SMTP id 956f58d0204a3-64302a3a8d1mr19964013d50.14.1764445986251;
        Sat, 29 Nov 2025 11:53:06 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c073e07sm2844621d50.6.2025.11.29.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Date: Sat, 29 Nov 2025 14:53:00 -0500
Message-ID: <20251129195304.204082-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129195304.204082-1-yury.norov@gmail.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is only used by i915. Move it to a local header and drop from
the kernel.h.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 2 ++
 include/linux/kernel.h            | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index a0c892e4c40d..6c197e968305 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -32,6 +32,8 @@
 #include <linux/workqueue.h>
 #include <linux/sched/clock.h>
 
+#define STACK_MAGIC	0xdeadbeef
+
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
 #endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..61d63c57bc2d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define STACK_MAGIC	0xdeadbeef
-
 struct completion;
 struct user;
 
-- 
2.43.0

