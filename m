Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1121E08D;
	Tue,  8 Jul 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003527; cv=none; b=J8tBYZZrFeo1VoSCbc3BsnSt5duEREuflLqIzjsmVvIDxsLMoeRbaR+wKT5a9jw8vy3yTqRBXHaoEyIDcJPtLMPw+h1OZ/X1flyaaIC3kEUWQzGEz1S+SyvF0ZpLRdtgEyRcD7Dw6c5duBzjGFCRa6icJMx6iChsx/PacG9u3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003527; c=relaxed/simple;
	bh=nVC2iS4sClY7u807TQfWCbAZEkUsGmhqWpv9rafvYAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/YeqKcOByew58nJDZYml178eObPEtxntSCer1G9F3s8uTm/IcyFmHKpshd6BBFFRqF6oKZQ7j/A7QJdWugaupIue+hD5avl3dk0m4zWXk7WRS0O1WqamhXAQeBFfaCPcJB+gM0qgvmxz5KdOGxj5LaARkYBx4hTS1k3eIpwYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8bb9bqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8bb9bqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E24C4CEED;
	Tue,  8 Jul 2025 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003526;
	bh=nVC2iS4sClY7u807TQfWCbAZEkUsGmhqWpv9rafvYAw=;
	h=From:To:Cc:Subject:Date:From;
	b=L8bb9bqb3IkVQXrSSgqW5W4t2Z9Fe8rvTVu48ecgoL6Ikb2snsG77o2s00bFsoPPQ
	 gk7MWl92Ao366aObR18t0yVjOaIb4weVuwP2Lvou7kVGxTPRnunx1AkEJgSSMZOZm5
	 Pzwmw59U/mXFOk2KqiQ8uJua4fM9KBz+FdIbTcQCKP1SSPlWRwLEg93Uy3807gU4IO
	 pGUvtXnn0BBniIFI/7I9b3bBnza6vx7lZ8ku7p0TTQhztUbMTUwa3zvy6xY983drfD
	 AEi6nIEf8LAp/WJdQ35ZykjrR7Rl8aJxkmGGxbFUDrVn7JRcOsJxVSPmbkGZkd2MFE
	 KLs1MFpTcqvXA==
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v6.16-rc6
Date: Tue,  8 Jul 2025 21:38:20 +0200
Message-ID: <20250708193822.45168-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.16-rc6.fixes

for you to fetch changes up to af1ccf546e5f2915fbbde26841db43a971d81cf3:

  MAINTAINERS: update Daniel Gomez's role and email address (2025-07-08 20:52:30 +0200)

----------------------------------------------------------------
Modules fixes for 6.16-rc6

This includes 2 fixes: one introduced in the current release cycle (v6.16-rc1)
and another introduced back in v6.4-rc1. Both have been in linux-next since
next-250701 and have passed the modules ci tests using kdevops. Finally, as Petr
and Luis mentioned in previous pull requests, add myself (Daniel Gomez) to the
list of modules maintainers.

The first was reported by Intel's kernel test robot, and it addresses a crash
exposed by Sebastian's commit c50d295c37f2 ("rds: Use nested-BH locking for
rds_page_remainder") by allowing relocations for the per-CPU section even if it
lacks the SHF_ALLOC flag. Petr and Sebastian went down to the archive history
(before Git) and found the commit that broke it b3b91325f3c7 ("Don't relocate
non-allocated regions in modules.").

The second fix, reported and fixed by Petr (with additional cleanup), resolves a
memory leak by ensuring proper deallocation if module loading fails. We couldn't
find a reproducer other than forcing it manually or leveraging eBPF. So, I
tested it by enabling error injection in the codetag functions through the error
path that produces the leak and made it fail until execmem is unable to allocate
more memory.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE73Ua4R8Pc+G5xjxTQJ6jxB8ZUfsFAmhta7AACgkQQJ6jxB8Z
UftulhAAiK78CFOdIcKbGKMD8tBGCHUT6IVCskY0E3aqDmhZiNEXhpmwKnOq56zo
ztbwg81Acc41t0Y283vgmZuEpJbzmS47qRYIZEhk5BuLdKl3Hn91Iyi3sdZLB9gD
VaYkpY0y4V3pWL5AM/9rtnLvY7PSLZG0bnAeS2fsOzxN5DIn2IIdD3WsU++96O+k
LHIik7dXcBQQKOukRClAI+cZiU2IGGG/FcDuMmANcsw+E4GKTBQunZiixTZOjdgi
e//NMYw1+Y5DJQ/i7C3Fl6+W+r/8/HPkRxyZ3Wt79WBZxwV/Hp5iTG9652vHKE1i
ybBDwlJkQC/EQsup4NKzDby38bPW1tdYwwK0dNbMRGxNICqNe7rq5fEG4WjTjXAA
H2O5VZ84Ys1SRx+uXeu83aog6fdiZ9DezGuaxFgrTRHUken2QvxJ/HTXe1BmMNY5
9BbHPrG22dp+dEDptSVaDWWMQZ6OP73gXrPYowQC8/FOm9NdBXVIH9hvvI7KRSf5
OC4A7nyZCDNW/Dwzc6yi3qAWMkKCR6IGMqN9vFiR3iIkaHJN1KABFzaVmh3JpR+B
6TsuO8/EIu9Ue25VgMehSj9LuGFgbhcfg40N2Fj/7+vgAM4Rd5sOw/NyiaD8xUPC
j0Ql4ehZiOQof8wAhdxpHFQQjO30UdpQgOmUO1yNUdmuPIpdSN0=
=dQvQ
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Daniel Gomez (1):
      MAINTAINERS: update Daniel Gomez's role and email address

Petr Pavlu (2):
      module: Fix memory deallocation on error path in move_module()
      module: Avoid unnecessary return value initialization in move_module()

Sebastian Andrzej Siewior (1):
      module: Make sure relocations are applied to the per-CPU section

 MAINTAINERS          |  2 +-
 kernel/module/main.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)
