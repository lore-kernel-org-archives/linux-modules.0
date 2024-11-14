Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFC1F8F0B;
	Thu, 14 Nov 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580306; cv=none; b=To8Men0ZmPJyNWaYR7iAbE79yrL/jEzB6xLB+BZSv8cWhOxMdSL7UNn46mdMPIc6a/uRJLYrNIp/My+Vkc0PobC+VznSicVPQ1LB9++HQZN7joYX7kCV2rpBA/fyv4sNk3bfSo5plGAO2v3CugUQEFuCM9q9DnhQ0s1RHdOtge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580306; c=relaxed/simple;
	bh=jMqaYGfAx4uupmaoHgEFR9A0Bf8uniA2ZlccS+XaBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YA8ENyADXuOxeeOZI9neqG5ZUyceOKpK9B9mz1KIaH/ZH71Typ6Yh0AX7/qAwq/9l0PKx0r3dHDRxr87hLOrHY5Q2ycsqQVeREwesQGjQ/PM3cQzQTcAB3ZtC54tm7r4hQn0Y3Em5kgbmsIS3qHXKHATtAs1/EtgXr507H2I5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKJGcVqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKJGcVqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CCAC4CECF;
	Thu, 14 Nov 2024 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731580305;
	bh=jMqaYGfAx4uupmaoHgEFR9A0Bf8uniA2ZlccS+XaBPY=;
	h=From:To:Cc:Subject:Date:From;
	b=YKJGcVqQEO64lR9jC9PFwr9rCRFF+UABckYgHB5C/YK9/q9VWMMmXlSaL7qs0qBGB
	 PZKT4KH+TOj5OeYOw4XKO2p9FVfvuCJTcxo5Bk65pvgGPQQnY3pnADCsNw7JwQ6Rnr
	 xvJEDj5qAj/nwQmjNQe/f1bRW4IxBhfVPX5ke1MQLqPy6V3/+i6Ik1+MVXiuguVbB5
	 1o1ZANX9zHFl18ndIiNdMPJ9qCee4HObxGUxr3GWDt34c7wPv+SU21eWlgVO6YxhtE
	 7YICTWe5uzY1t304g/m3Vg+7UKP8XyShniGxsfeHX8E94nDQk1JN2Tf0LvrJ7ISxT8
	 7MTabqSJH9boA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL symbols
Date: Thu, 14 Nov 2024 11:31:32 +0100
Message-ID: <20241114103133.547032-4-ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=ukleinek@kernel.org; h=from:subject; bh=jMqaYGfAx4uupmaoHgEFR9A0Bf8uniA2ZlccS+XaBPY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnTTi63qixkmqf+wmcmy/1FzCcvyS1IHd4qocmemyi/Y1 mHwWqy2k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJXPjF/j/qeSpz/u6lUmaC pg6zHdqEBN3dDhcpneb4fETua0bQ+aedNnU8b+RnZoRx3AhL+dCs81LB4YvHlunljieWeXxdru5 m11fP8VqHKavjfPgihaojh48GVG/nkZyjOe1+mvSdrLlGD42V5u7VsHcwfLWzPCjgqLt7aETf5u weXVPvGJlNrr1PphRcXm3onnRW1T/2y/cTD+585W252qV8Zxr785Lc/LkqQnUftYs3z+9+kdfPH Zn11C7+WOdV0RI57iWPcjZbd/otZp5mcm/NY9N3spLeSxcofo28nujj1nw5aWaUXe3XQwUdWplf uXz9qizEpQtVfe2P7lKbH3cxSm3WgU9mv2x0Q3UU1d8BAA==
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the kernel modules provided by Tuxedo on
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
are licensed under GPLv3 or later. This is incompatible with the
kernel's license and so makes it impossible for distributions and other
third parties to support these at least in pre-compiled form and so
limits user experience and the possibilities to work on mainlining these
drivers.

This incompatibility is created on purpose to control the upstream
process. See https://fosstodon.org/@kernellogger/113423314337991594 for
a nice summary of the situation and some further links about the issue.

Note that the pull request that fixed the MODULE_LICENSE invocations to
stop claiming GPL(v2) compatibility was accepted and then immediately
reverted "for the time being until the legal stuff is sorted out"
(https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).

Best regards
Uwe

Uwe Kleine-König (2):
  module: Put known GPL offenders in an array
  module: Block modules by Tuxedo from accessing GPL symbols

 kernel/module/main.c | 56 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 9 deletions(-)

base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
-- 
2.45.2
