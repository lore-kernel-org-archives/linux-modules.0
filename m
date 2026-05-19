Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E523909AB;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171977; cv=none; b=jcPAFUirqq/Fc34zXuOjSexVpw56Sx7tXPxmDAOTwlXp//+8rf8+pD1YcbnNLeKLqgR1cPvI81AUebGhg7U7NJ/XK4BCConapGHIHx6nhvxoYbbW2cyfmz8/4QPPLkafZis7cf7qc/26o83OuIv4npVzHnsY8mTzutwBV3Pqo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171977; c=relaxed/simple;
	bh=9Z9wAsI6CYGM9qPQGM6HbNxhzSLG4aRh4Z3ixoqvDE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osbMrZtph9IIb37n63Vf5DxOfLlQMZzag3v9FC5YsRtSawHmfjJHehso38nBgb2+Mv1Awm9o+Bj6sFPVV29gqUIjwoylytoX71SUW/gYF3RbCf3StZkTEukiBof/RI12Gwg7aYV8LMSY3UJ7LfoZLxhjisuRVn+s/zSF/eM/PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=1kiIVOLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="1kiIVOLn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A60CC2BCFA;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779171977; bh=9Z9wAsI6CYGM9qPQGM6HbNxhzSLG4aRh4Z3ixoqvDE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1kiIVOLnBUen5Tn1JaIZpays9z+1J0Kybl7WUzAHRh4W4IhG+JLrO202e7qMMharG
	 fAc8djvUVpxV0IJBIjDUYNVCzE5WqUpDDdseUrpUDOVRlzfBSZ8b97Y2YOs98TUyq5
	 UMl6xUJ6fXHqFcr5SEd0jxvzY/JtIpGTnmZdLUoE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62FCD4F58;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 19 May 2026 14:26:16 +0800
Subject: [PATCH 4/8] gpu: nova: implement `ThisModule`
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-fops-owner-v1-4-2ded9830da14@linux.dev>
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171975; l=694;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=9Z9wAsI6CYGM9qPQGM6HbNxhzSLG4aRh4Z3ixoqvDE8=;
 b=5tu+ljTbic4iFxV8s9jKyOts11sBxBoViBntzSvf9qqyEQD+HdB1HSeUaRJ6XehDZwXtw/HCj
 XOplTY2EhRQCkwdT+ebmsCgDQb4BBXxhNMiT7mIAHqaAR0Wd7uZ+o/F
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Set `ThisModule = super::DriverModule` to provide the correct module
pointer for file operations ownership.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/nova/driver.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551d..6353c19d319c6 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -68,6 +68,7 @@ impl drm::Driver for NovaDriver {
     type Data = NovaData;
     type File = File;
     type Object = gem::Object<NovaObject>;
+    type ThisModule = super::DriverModule;
 
     const INFO: drm::DriverInfo = INFO;
 

-- 
2.43.0


