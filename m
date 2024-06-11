Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AD3CF6A
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=gea91+9MhRzV/Soq20IKIk2dDZFjzWmd0CHslbEPkOxYu8swi/VqhVmr9/BP6JrLKN6AIAfgr5s+Ee4YBesjn4eJxZOeBFmVfRgc/T+sCn5rh0NmhZh+lBPoBSRIjWOm00W8byY2afq1cJ5Q9TYR7GW3RNBwSVvY0lI/jKCCEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=UJYWSb2Y4QsAnuYtl7oJ6cJFvfg5TbfC7TPgwp1MB/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4cpGRh5o6G4OzWajWIrP7YkKsU1GeBuuN42DaYZPDxqP54Mc+RrrTj/rX7ECnueng4Yi9qzfNxW2FEf3Y9YiLdU+F7H6piCu+5xVsCYPF4UO2/BeYJhubwEgbWgQ+YccIi2n7jDG2fZe0XkUx7VP4t9dHSrlYf37P/BR3FnoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe8N+LoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe8N+LoS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 036EAC4DDE3;
	Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118305;
	bh=UJYWSb2Y4QsAnuYtl7oJ6cJFvfg5TbfC7TPgwp1MB/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oe8N+LoSr38amoECwvd8uZoz9SfGJ9BYdBP7tPe7rKO+0ZEUsSkKlVVi/HXy/CD4k
	 XViQvSkMjh3ddpgAVzIlMiLGaIBXe8ZsDyvHMjr9/I8sVtry95Nou4yWaP+s5yDiYR
	 KXgMyuyVOtfsBVf+O96x56+XSuQWQ/DECVqDHuLAMXCXf4hvmJa9H2Xg0q6kIRMqW/
	 VrZUxNyIFvzPRrpoGFWot+MA/nl56xHheyKpum/v2uufSBwr84SycCcJCmy9xtC9Xw
	 wqGj6vMnVDtM582oKVHLE3NCMabqGeZT434g4SP1/vc2K/LMwOHBDNtJRS5mvThIgb
	 jlYKiplg3rOqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E813CC27C75;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:17 +0100
Subject: [PATCH kmod 17/20] man: modprobe.d: mention about MODPROBE_OPTIONS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-17-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1492;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=i0qBUwKgbC+64tmZG/2a7YKtjhyh59kDUIlSs5fyIrg=;
 b=wPqeIcdKIzbkN0BkqDZMzMtLAKjqbqmXgz44m7nHejkTwtzsHIqZY0J1hQ6xTIsgK2wCKJ378
 eWkH/qpVk4oAVzff52T/QvZYyDJvIx8ZAFYuNjxrbK9B3Q1bW83UiFs
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The environment variable alters the config file ordering, so mention it
in the man page.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Hi Lucas,

Looking at modprobe(8), while the variable is mentioned there is no
details about:
 - the format and it's stability across versions - is it ABI
 - is the same option (say config) allowed multiple times
   - if so, does the latest(?) instance override the previous ones, or
   - all instances are in effect, with the latest(?) having the highest
     priority

Can you shed some light? I'd be happy to put that in patch form :-)

Thanks
Emil
---
 man/modprobe.d.5.scd | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index b300758..9d03c49 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -46,6 +46,10 @@ the SYNOPSIS section above. Files must have the ".conf" extension. Files in
 @DISTCONFDIR@/, and /lib/. Files in /run/ override files with the same name
 under /usr/, @DISTCONFDIR@/ and /lib/.
 
+NOTE: Any configuration directories set via the MODPROBE_OPTIONS environment
+variable are added with the top-most priority. See the ENVIRONMENT section in
+*modprobe*(8).
+
 All configuration files are sorted by their filename in lexicographic order,
 regardless of which of the directories they reside in. If multiple files specify
 the same option, the entry in the file with the lexicographically latest name

-- 
2.45.0


