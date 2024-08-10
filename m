Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2482157488
	for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292727; cv=none; b=myHoL2Oh2beEh+Tf3mceih6JlyG8hRiAByrzzK4BDU0TUZzJfmkWK2CsCaU/OLlusZ1FuskBY1WsK4Cz7OcdJUAPsE9/GEmI9GZ8CBeS1pQiSuKUHOO22/MXm9qk8OIHPTv/U3kLkGviggf9x/1Yx4u3eEE7FUd8mCWZqvAgMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292727; c=relaxed/simple;
	bh=wOHVJ5H+ilz1a1R5578g5XOMZxAQTNQ4cTfxrsDR+Ic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M12S4t/WE2XgCphRR14XIDMvR3CveqlPrrjlx4or/WNktmMXc9oo4jzRDHZFjdS3NpwM2iF3aK+qg8I+/iQoMVa3m4U/WoCdW1u37frAo96DLd3yiE9zWixWO6GjevqncKnjgtOk0t0CcRdn/lCz27glf8iQwj1hoV/BV56IX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYOStea1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYOStea1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32B30C32781;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723292727;
	bh=wOHVJ5H+ilz1a1R5578g5XOMZxAQTNQ4cTfxrsDR+Ic=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FYOStea1aWFEPHy5/8WQ32riKOytK2eUll4+a5bTO2fsK+b3lnNBOSh/1mXfhQL8N
	 wROx6K41n/44fBi6yZLH9ObS4xA/ofTfxWp3CKVqlZDwIYw8kivmxvbBfnhIZIXMkQ
	 FH18yGsU/5MPjW3Q4EY2tPiQwzv6D/0fU5zcHxnh3uPTWQXfZ6MP+FGy70BO5kv1AK
	 xnUPQBIEcQy7dM8emEF2wOEpvmyFU/BCl0jfdKq6nCLVZrPT0RJ7P6om8Gmnfn7qLR
	 rOVhOgwMPcIYmzQT0klHRfidfn2Qbquek5SZ8ACk5L+7iFFtHcvt4+TO4qQDaabzqV
	 zkHglHVgAN/XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFEDC3DA7F;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH kmod 0/2] Couple of SPDX fixes
Date: Sat, 10 Aug 2024 13:25:14 +0100
Message-Id: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpct2YC/x2MQQqAIBAAvyJ7bkFDSvpKdNDcai8mSiGIf086D
 sNMhUyJKcMiKiR6OfMdOqhBwH7ZcBKy7wyjHLU0SqLTmKMveHB5IrrZeUvGTdJb6E1M1MX/W7f
 WPvV0rBNfAAAA
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723292726; l=857;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=wOHVJ5H+ilz1a1R5578g5XOMZxAQTNQ4cTfxrsDR+Ic=;
 b=UGtH1lYs4R6M5KdqytjVGwm6VB4lOy81mD+sjgSwsOMlGj8AvulAkNfDrYS3mfYOq0oI9RECD
 0qsCLC2PrrYB6zyxRDWbmnxw/38iR7OjO8xx1dOIG9Z9OinVZhqNva+
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

Hi all,

Seems like the revision of the SPDX license identifiers, that landed in
master, dropped the wrong hunk/paragraph.

Namely: a function description/summary was removed in one m4 file, while
the license exception in the second m4 file was intended.

I've left the two changes as separate patches, since I'm not 100% sure
if dropping the former wasn't semi-intentional.

Feel free to pick whichever patch makes sense o/

---
Emil Velikov (2):
      m4: reinstate CC_CHECK_FLAG_APPEND summary
      m4: remove verbose license exception clause

 m4/attributes.m4 |  5 +++++
 m4/features.m4   | 13 -------------
 2 files changed, 5 insertions(+), 13 deletions(-)
---
base-commit: af21689dd0f1ef6f40d6ecc323885026a07486f9
change-id: 20240810-b4-spdx-fixup-b7bdae8b60da

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


