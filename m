Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0153EFFAC
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101281; cv=none; b=d0EygMuIYcBVZW4fRSYXz6UoPdeS2DGgpW14yJncA/HpoLbCqJi7OaUcQk+V19xdKswPlCnELJn4fxKSWRWZrAEeBgrABScvBgc3+35d5CT9o4jCLZzNO1E7cs3P1VdoZudtDKkbqNK13sJtYWaYIYGTsU6hJT4Nt/tEv47TwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101281; c=relaxed/simple;
	bh=TbZi1MbwhQltQFM5pKHqcADDb5nmjIMAmUBf255JCWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POsGazVbuwcn2cAhBOjqThEUnQYILPelLxHesawaQzh0ueBcLSGmYW+f0ahU6+dRtBaiwSD4jNrz23k5u+6oDjUmOAnbcpIB5TMOTG34BF5A0Zo0rks4qL84GwgRBFMN9wxplaZF0MneETU/I6YlZDdwhSfZ5gK7ut/cyHLMAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPLI0dzp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPLI0dzp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c1a170a50so2395716c88.0
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101272; x=1779706072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1SpA4orJK3lLLlU0ZTtdxmVVGa75mJyXOYMf26B9d0=;
        b=MPLI0dzpYDzrRnzYXnwOnu4+mDBKVxskBkU4fu1hibHAwZHijGeGDBnBoBvdnljzMr
         kQpYt5M14KH2DBT4E5t06LxJV6P718mfNRZLGJsewyIq1xo3BhOLi6WhvBwyx4QxEqo7
         Ho9WxnUjSFNcuK6VRd3EBUz2u4uoDbBUFrNXSTiLwfPw/x8hIF3DCriOuufGb6FLe9Er
         LvoPTB5INa28zttTHk2LVEYPTF9pOQh7CC4enO9nRypdgiwCF6mhBMt/gUBM9vv3w1XG
         FyDI6pMfllZVej0yPyJpuAx9qED3JQXEzqj7Nmvzl6icw8y7sX7LkzyoMBateGnDUy6H
         IPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101272; x=1779706072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1SpA4orJK3lLLlU0ZTtdxmVVGa75mJyXOYMf26B9d0=;
        b=axmjcwwfIynWGYGxKcR57Mn6fTCxW3LsyPa5Bb+Q1E820jEWsK6aJ9z163fwMGzNHt
         oHcuU89ReTuR7CegS6VyO1JF73+uey/uq0aaiqhAks2zRiGELiEy1iQQ6kFwpVz+as1a
         mJtLfKq3xptFIBiyvKQE0kPZQP91FMflmIzHhCn17pTRIAY7jsXVz27E71+i3dI/Nl5i
         dNfFx8mCYoWf5nZgee0fOLJL61KVK9Ng60INTG2GwgZzddEAtrOT5q8dumzVTz67hqHk
         KVrQwr03NphZe3ckprMLDn4WsXOMkNOLZhWoymdOmGxKH8ub9Jswe7KQKYS/k5j+7pFu
         73Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/lrEldId+uqpBAFdxBgZKIEAfS2aVj+My8jX7SXVZ4lXKwoYrOjZU9kctY5NQyJ1HSzzUxV3gWm3mvbGPa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AKsOSu77ttAv+tdG2usAqE0ma4lGy8o50fMrPI1RqWuHtJ7L
	DqqKVOXpceKjh2MxVNwXYw8OKa1FC8kXGc2PPNSsPJxvXxnJVQa5v8/T
X-Gm-Gg: Acq92OEqNBzT4Kg1GBLBiObu433jF1DsGykl2NH2imxmU32v7YLf4gJMMrCrp4eVN6G
	vH7zojUWzsDd2bys2ocgjEmVTID8TazMMODcOBRxXwDCcK1uS85c23QfOaSkjD9cjp6a/l2N4Vg
	5HQRn0oUgzGpiCShIa7rXnNju1EwT6Kx0zrEID2JSIX6LTsRhrEBL70ir8rel3wkmwBELQ289UO
	OySpIIFMXR8VnBpeVGj+6429hCVlwqME3zuUIdo9gtAupsuQwjKlWD1nKQUozbdtm7ouipbOX+C
	ZlWUhFseCn07XOXHaeDngIzt9PJ5aeSAd2C/4+sRUTGC6R9IlyEuOYM7ld1LvCmvpqU0jbWegd4
	tKHW1NDZvzKFdONHYWpFW7tIE3G9MhGcXuODveyg2HUJAlLFQPEajKX5tLXZw0HGsn8MkjF3KW0
	bkIlfShddJpCVBpB3G+aPgtubQzKdL0QY92uojEQKGBLWiOw==
X-Received: by 2002:a05:7022:311:b0:12d:b396:eaed with SMTP id a92af1059eb24-1350440ae04mr6279368c88.9.1779101271435;
        Mon, 18 May 2026 03:47:51 -0700 (PDT)
Received: from localhost.localdomain ([192.204.47.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm16703237c88.15.2026.05.18.03.47.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 03:47:50 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] rust: kernel: module_param: replace pr_warn with pr_warn_once
Date: Mon, 18 May 2026 18:47:35 +0800
Message-ID: <20260518104735.34906-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 rust/kernel/module_param.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875..fedb709fa 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -62,8 +62,8 @@ pub trait ModuleParam: Sized + Copy {
     // NOTE: If we start supporting arguments without values, val _is_ allowed
     // to be null here.
     if val.is_null() {
-        // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        crate::pr_warn_once!("Null pointer passed to `module_param::set_param`");
         return EINVAL.to_errno();
     }
 
-- 
2.34.1

