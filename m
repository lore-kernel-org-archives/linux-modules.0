Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81D26AF3;
	Sun, 24 Aug 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018177; cv=none; b=AKW+CqQV5SJDmaPmTgyxVTLRX2RE7h/x9VAYahYDxszOQCcxupF7xjTUNENsag6CSKC7qoN+ZMFq7Ss9129tVnaNXCcLxWwyCvYTvuED0ODHHZyoaPve/R3JhRXWDVeuqdCAakEoDIPRFr7Q/D5DBcsNDEERnUG/MxA+VRweluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018177; c=relaxed/simple;
	bh=vjhwqZdkiH6mHK7aTu8E7/2yCxOYf+cGyqB1mL4hPSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVNBgSMWrSM8StfbZcMtlPTMe+wV4N3kRlrIRZo/zwOy0U38pbq6gutpwypGoIBZoS7diD+T5B5L2PjDcJBKeLmKpTh+k02kZcdc/i0jkcoNHOk6IBD6WwmrQ1DDobQQliuaRGF0hzy8uhZh82F6toFU6kwtRm+d9/ZS0oDxAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq7MKQTA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq7MKQTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F413C4CEEB;
	Sun, 24 Aug 2025 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756018177;
	bh=vjhwqZdkiH6mHK7aTu8E7/2yCxOYf+cGyqB1mL4hPSg=;
	h=From:To:Cc:Subject:Date:From;
	b=rq7MKQTAJ2g+4kiqJVyU1nfS9ZVcrpT5GaFP5JcyitmnN5wea2pFMVTulGINHJlEs
	 LOKBzpzo9oHv4gckk3oyfhMGLXtzjzu1TtlDnYzL5JXxGs8noeABq6G92qs4bSnD/C
	 Q6bp2NG2TU0b6ZSyyMjLgc9wb2e1wqOCRWOMAB7AQdDzwTsAMfcpaPSPxrHBdQCZYK
	 qUVMNjxmBDuNFitxSJjrZnDFXPJIZ6TqTKVIZlH9mpXvKRolrDuG6n+D5RSaOHVp9+
	 2BaGk7u5Bvq1Hm41CQnj5kAbC/i8AwgSuYadB4ZZ4bVVZZ739df27o/YqdEzppMtJo
	 ttzKnKqZBD9tg==
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v6.17-rc3
Date: Sun, 24 Aug 2025 08:49:17 +0200
Message-ID: <20250824064922.41894-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.17-rc3.fixes

for you to fetch changes up to 5eb4b9a4cdbb70d70377fe8fb2920b75910e5024:

  params: Replace deprecated strcpy() with strscpy() and memcpy() (2025-08-16 21:47:25 +0200)

----------------------------------------------------------------
Modules fixes for 6.17-rc3

This includes a fix as part of the KSPP (Kernel Self Protection Project) to
replace the deprecated and unsafe strcpy() calls in the kernel parameter string
handler and sysfs parameters for built-in modules. Single commit, no functional
changes.

Note that param_ops_charp still contains the last remaining strcpy() call in
the kernel/params.c file.
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE73Ua4R8Pc+G5xjxTQJ6jxB8ZUfsFAmiqshwACgkQQJ6jxB8Z
UfuF8Q//UVMLtvEREUM8m18u1SVDhnO9/+Dpl/bkTof+w03KviIbAN/VXm6qn3C7
ZYtK5lDWU4twg+bOpC6EC/LdNVNyJx6cCpqkZFri21i9Yhf5ak0Sp833lWTZdqH/
DDNCCAOuFH1EaihlJwQ/T4ox1CUOBTC49HyCBnVvdWiCCevUaPbxc8Cgsuzp/gsf
vqXoOJCYKZD2ZdeRKgW7EgETWUljIpvjfXnb3DtMHztj92wzHPaCR50d0iBJbpZi
3JEmrZ6FQ+sb+Qgp4VrW7ZEIa8UFGusqKVZBzJfZR61OU+iVz97gg2WptczsTZCa
GoV0sM5MbNwaBtaMEoM40OiQWCAtYyfsIFmOH142Djcmzgs2hGFTGMKgZReDRs8B
XiPPTq0IW5czYLoNyzJKvtoRX1qBC7wV0rxN9MY8AQieCPmhV3fQsjUgnPKwUOlV
4U5EvzI2Qy4LL5oEUp3rEcymio/rP1wrd0dFxx/D+bMMj//PRF+9rr51deZ/tqtz
Y0Q8rI7CYYlhg0I6XH8t2sAe2TypbU8gNGhOi23Z9vBZwtOv1e3fGTQXymopvVT4
m50c541senApTKFHDbbck2KXwNyasdtIWCQrtChaP99Y0Lk2KRxkgYtVuCJEPNsv
rFjyK3KnfkhhqNJEl4I8EUJwfQ1z9tUHJyfx1p0q74cShV7fRg8=
=8/92
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Thorsten Blum (1):
      params: Replace deprecated strcpy() with strscpy() and memcpy()

 kernel/params.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
