Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909914;
	b=UQp7snAaY+2iMMbYqDRR+RHefg9BcLdl833pISlo7mvMH1d7WHkijJj6mO3Gw0/24JI/
	 K9HeWYjaTpscRQ9QYU1FS5lJif8yZSwzTdIHYY4VdrRyKef4Hy3Ss23+UKYbv2OUXoCHr
	 uQe8f2em/DPrVsJeFGIYmnh6iQ6g83j3JsQGT/B27YThq1VoYZWqGIA7Ss5fJVYhIgd+m
	 x9kZxIJqLxVg/VO3AHHZUf22/ng4fbXvhF1HGwdKlMy7xPeDyVQLe0gKka5G3az6bOEYK
	 NP/eBXwO3mmntC2l2xoq+KDGvsk0bs7pYYgIcah6wA6k7oymjhNIwsDXYG1Rq4zCXgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=phgScYuIuJgj5n9+MHknZ2SxB6ErMi0YKuc3fUy/UDk=;
	b=ITtjQ6PJH90Up6m8KZsGe5JXo8FclAR4r194c8Z1xteWq91/NXI8hZBgG+brSQ4oB5pZ
	 26NXeFwDD9ssOg2KT1G6Djb566mg5R+NO6j6ybTyMjh6+fIyDx2rygMLCwrAvZ/DrDgTE
	 9gY1Z4N55jAn+YY0XisPUF1JgNX7V+7IcB7Tl3pZoIrQ8li1sWDJBi5cyoVqP0M2dcJZw
	 P7iF4wmh2u/KSwIjdQK1VMbeOm49xCJmUokWfWl/uYihJ+o1oGqpibmLCz+VtsY9Yxs8w
	 0m0T6dL6Fk9omF/F2XPCPW6FZG0XI0FxPmf4zy1UABpt8jo5EOA9oGK1P5B4yP8GveQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLRaOpga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F64606A33C;
	Thu,  5 Nov 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLRaOpga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB9A1F008A4;
	Thu,  5 Nov 2026 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909913;
	bh=phgScYuIuJgj5n9+MHknZ2SxB6ErMi0YKuc3fUy/UDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLRaOpgaZqO3RNQv6fizNW54BkuXpjaavNoZ5A7+L+g0F/8yvL9UfNX8N9wXhh756
	 5hib3YJf7xpxsAEYlqgM7rvPbShw+0R1jrD3jsjfs3WTSDpWIqcs/h/Z/xZcUCUpZw
	 dPfFaOSYEUYzPfVtbRHMtuOOCCw4OLvFze4IXNx4XHCSIKgqZ6q0JTg0i83Oj9eVoz
	 A5CEjCFQfw7s/gHfb2kvo90aOReWYIIhmcYYa/PipBcWDFDIakIJ7xgpUfQWP6IwJK
	 Wnf040jZQ4GLov6T2eqWXBk5rlHdDb+RVPZL3+btrg2T4RjPKroFvt3vROILI09Dwq
	 GJSE3GIEWQFmA==
From: Sasha Levin <sashal@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v10 1/4] kallsyms: embed source file:line info in kernel stack traces
Date: Thu,  5 Nov 2026 15:18:32 -0500
Message-ID: <20261105201832.3238538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-195130@kernel.org>
References: <20261102111455.919102-1-sashal@kernel.org> <20261102111455.919102-2-sashal@kernel.org> <sashiko-outbox-195130@kernel.org>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 11:15:24AM +0000, sashiko-bot@kernel.org wrote:
[...]
>In elfutils, libdw.pc lists libelf under Requires.private rather than
>Requires.

It's under Requires, so pkg-config prints "-ldw -lelf".

[...]
>Can unfiltered ELF symbols in collect_symbol_starts() in
>scripts/gen_lineinfo.c corrupt the symbol extents in text_starts[]?

No. Filtering them changes nothing on x86, arm64, riscv or powerpc. On
arm it drops three $a symbols that start line-program sequences with no
named symbol, and those addresses lose their annotation.

[...]
>Additionally, why does collect_symbol_starts() exclude STT_NOTYPE and
>unsized symbols from sym_starts[]?

Without a size there is no way to check that a covering row belongs to
the symbol. Untyped labels that start code are almost all in assembly,
which gets a row per instruction anyway.

--
Thanks,
Sasha
