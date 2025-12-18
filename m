Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC542D73A7;
	Thu, 18 Dec 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091610; cv=none; b=bXib4gsjM1Rda78bbN+zjtJ0Y/l+kOV4jlEOu+/dqH9xuQvD5oWPS+37BQyMmphdgY4KzqEfWnvNAZd8TAbuhLh5aN6SoVpJ1tIltZ0Zi8m1BsH/WHlIOyP4xWF9CcdaDlmww8LEDMFlO90a6ZIdZmuGFkmh4qYt4U0RdxMZChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091610; c=relaxed/simple;
	bh=ocVyW7CGSJZnuRqGhBS2hiaA0KAEoYpXnxRGkIt+GEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UFYvfNc/G4RjWjpCH5gMGVac2rMXVtGm4xJU8KTi2JfvagK/onk+LVCoL6uiiiUh2rVYJ3uLs/yUk6LqI1mrsF1I1bRY9OI8sXL77vzaWc8Hbc8OBd9qLNmzpCwi5mkUrjQQMtlfg23TBZHf1xw13fOglEYPniWhGyskgNmFQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtcP7kCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtcP7kCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6493C4CEFB;
	Thu, 18 Dec 2025 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766091608;
	bh=ocVyW7CGSJZnuRqGhBS2hiaA0KAEoYpXnxRGkIt+GEs=;
	h=From:Subject:Date:To:Cc:From;
	b=EtcP7kCegT4Px2JQrRa2PLTqCF3BmKjDxvBVGNp7QVyhw4EFSWG1FT2ixpun9NOP0
	 KOmurcJzjwj/aH5DllRyraorW+oF8Y0wSPJOzwS6Zcf50NDXlmgv+IE3AnZYO2n8P0
	 qNYAJrxZL0I+lNOaHX0klfR23sUSS84UHFKHgpg9RAhZTf5nnLPE5Dwr0X8rjsad1u
	 5pamQUgU4wkpKma3B2QkXUukQc1unRQnzLfnerEwt9RuEw1SGbXL9iA19wqG+bCiuc
	 TKjvH5P27zQ/QWL7MQ3u85O2EBdqqULWYoQ1ggtWkRFBFTJb9Kc53Os5zATOqyWUng
	 4RiaU6wc7oetQ==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH 0/2] module: add -EEXIST module_init() reservation docs
Date: Thu, 18 Dec 2025 21:59:43 +0100
Message-Id: <20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9rRGkC/02O22rDMBBEf8XscxdWkmXL/pWSB11WraC2W0lxD
 CH/HpEL9PHMwMy5QuGcuMDcXSHznkra1gbiowP/bdcvxhQagySphRQGA++4bOH805o1VWQ+Uqn
 llRUMmy8ogh+9G+00OAdt6jdzTMfj5vP05Mx/5/ZWnyE4Wxj9tiypzh3rSHaYjFM9h3EgksFrH
 6My1NtBeENSKTta+G85dw9HEurtd7F5xcwV9RTJaDkZ0nreBZxutzt7oOyN+QAAAA==
X-Change-ID: 20251218-dev-module-init-eexists-modules-docs-1dc7cb7a96bb
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Lucas De Marchi <demarchi@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=ocVyW7CGSJZnuRqGhBS2hiaA0KAEoYpXnxRGkIt+GEs=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBpRGtSi2cujVCcKzKljcgpoR5IeiU7HBbjRjtMq
 XGKA5ybsjOJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaURrUgAKCRBAnqPEHxlR
 +2dhD/9sE/lhlbTTBuaXXDG9+Smy+AGq0fGM/gavw/WzTBxymsy4LpOjj840bglSa8DuZ83R+Nr
 Sw2AK5lExPCrEVUYBdIvGKyGMQvZM2wBAa+A06PjQ1x/zTNb+gizXZ/ARs8LVH7FzhRkq2DaUno
 RSVCiy6mWUkVi2clK7MnbDnCFr7HPByKz4qpFKGylMMXLFnNotgNmimMw2OAxXQfwa0rv68eHt1
 TtReXJ0ILDFpRMZjLDG83PmLn7fy2mySKH/ipKNqz7skzk2YPz16NMENQPyeH7uleAua5jfpTUo
 h0i70bKzt6gR13o6nI/ItT4EaaUBtVwxOrnlMYBcdfcX5fFM+3kwjMlspYVKENQkLCv/klkcV7d
 ZjlZADz2Vrn5CVHiR+R6VHxkK3WiMhwEqnQM0hvo6XypjvlposQrB3N2QImT+kUS4daTDBcO4nl
 6Lba7Ah1lggUTciqX9sgdwJNzQGnlLt6LC78cwiOq+t2aNXNCvy9yqg9FTPewWMieHY8R+/BnE4
 dItCBkDteBOo5oWms0WgJR0D2tIl0/OSK110IgDW9WweRL93IzP84A9XGCU8MfM6ATY4zDnM29U
 2grvIiD1+m9y8NTR0+odcQaESsR5gYYAIOUXNWCbzXYTbDY97Ac2LcnSVIFhtDCwkW8KJZBYk8k
 B9bdr90eZvtxdWA==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

This series documents the -EEXIST error code reservation in the module
loader, building on Lucas's patches [1] that add the runtime safety net.

When module_init() returns -EEXIST, kmod interprets this as "module
already loaded" and reports success, hiding real init failures. Lucas's
patches warn and override this to -EBUSY. These patches document this
convention to prevent future cases.

This was originally reported in this thread [2].

Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [1]
Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/#t [2]

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (2):
      module: add -EEXIST documentation
      docs: hacking: clarify reserved -EEXIST in module_init()

 Documentation/kernel-hacking/hacking.rst | 7 +++++++
 kernel/module/main.c                     | 8 ++++++++
 2 files changed, 15 insertions(+)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251218-dev-module-init-eexists-modules-docs-1dc7cb7a96bb
prerequisite-change-id: 20251013-module-warn-ret-59f085298055:v1
prerequisite-patch-id: c3e4f5b5d01c2b48b4c94e51a60469cb74691853
prerequisite-patch-id: 2d5a726a75f3b9d9c256b8478fb6115a92f04354

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>

