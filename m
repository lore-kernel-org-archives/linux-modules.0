Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE713E02A
	for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292727; cv=none; b=FEWvi2OzicTZxYt0bsmAVU8YA7I5XDkIdQQUvOnYFe7Bxqc9x93tTocEwuUdL26H0nUA4XA91OELIhsLDGLLnYmMKVwtIIiLc/eXIpYHIBu1RJ7F6iXlmywWJ0KahoqdY5tD80EDWyc6wWtjN6XOI1CNq6l2xaX40n4zixExxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292727; c=relaxed/simple;
	bh=jKLWG81C9L7T6MeJh+poogsU6/o0mKi42/7OOCmdamY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DI6SSwPW0aWMI3oNYNrqzgpTVt0a7QWFToFTajS5iie6mdanj8WUeCgLNOpLZkQwi0asVYFyASgMc+Z7Zf3+7HQ7lhookU0QtQpsu+I1JD/I9YrfzWlFaevYzaov6pYQFp+lJANndJxnAJWEwukIk9WvhkqBMkU2J55ItAARHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MACnCDTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MACnCDTl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C4CCC4AF0E;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723292727;
	bh=jKLWG81C9L7T6MeJh+poogsU6/o0mKi42/7OOCmdamY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MACnCDTl0uiGUcysNTY65LycaYGAB8weu/hkt2pnaDq1ZqeqnVkA6vWr8p4Nq2sDX
	 hZ0+ZtUTdKQtuzyRe3rx4m7sMQZyo/431hgk+6l3BI7TfQQld6q6eYeJQzRk2pdh0n
	 U6nco31we9OMKeaozcCxZPZYaVMAbXn8IfM0H5Pd46fck3fzhmYExNPGO1+2+0gtLL
	 8VTRXf0Pkco/T3aSR6j3qzC6m92mu15uh9cIUZXdNmeLDB/SsYBhPGGPEIGn5gZGOl
	 BHXzDJPLZoLA1p0Gi2/cRvRsvXRpkiPIdDS3s4i45EOO47UZAYANC8wbsk/o0piAh5
	 IMPWMJiKzfwYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A4C531DC;
	Sat, 10 Aug 2024 12:25:27 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Sat, 10 Aug 2024 13:25:16 +0100
Subject: [PATCH kmod 2/2] m4: remove verbose license exception clause
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240810-b4-spdx-fixup-v1-2-b9c84d637fb3@gmail.com>
References: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
In-Reply-To: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723292726; l=1516;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=4i3lPNK55/Jj+IH1COzPpCNGv9x/md4G29+CkWIv0Os=;
 b=fGnn/BmKGEG0Ko/XAgBKGXb+V0KzcimIZdE5SzHwbL5FJWcxXjAiKzHtKr243Ryw/2dD35cx4
 Qc4uncwgtTSC55hI5nkpgBSe500XCuezBgG7kKzVCZFjZI2YOfjnFgJ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

It is already encoded in the SPDX license identifier.

Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Fixes: b5a2cd0 ("Use SPDX header for license")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 m4/features.m4 | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/m4/features.m4 b/m4/features.m4
index 87ed2fb..6384a05 100644
--- a/m4/features.m4
+++ b/m4/features.m4
@@ -1,19 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later WITH Autoconf-exception-macro
 #
 #  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
-#
-#  As a special exception, the respective Autoconf Macro's copyright owner
-#  gives unlimited permission to copy, distribute and modify the configure
-#  scripts that are the output of Autoconf when processing the Macro. You
-#  need not follow the terms of the GNU General Public License when using
-#  or distributing such scripts, even though portions of the text of the
-#  Macro appear in them. The GNU General Public License (GPL) does govern
-#  all other use of the material that constitutes the Autoconf Macro.
-#
-#  This special exception to the GPL applies to versions of the Autoconf
-#  Macro released by the Autoconf Archive. When you make and distribute a
-#  modified version of the Autoconf Macro, you may extend this special
-#  exception to the GPL to apply to your modified version as well.
 
 # CC_FEATURE_APPEND([FLAGS], [ENV-TO-CHECK], [FLAG-NAME])
 AC_DEFUN([CC_FEATURE_APPEND], [

-- 
2.45.2


