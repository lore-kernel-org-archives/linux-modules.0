Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2A3D34A3;
	Mon, 30 Mar 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876487; cv=none; b=bWNaYYuHpsZb9RpqKv4l4f9rKMMAqyp8W2ZYEhEXbHa6QE2CUJ1xuSTEIlm8OokCrSWa+ED7OzgH6hLAcERyP/ZOhlamNR1UpDNiJ6mKPofeU6jHsmC6kGUNvAk+AqUOLO798zqGTYPGSImc42IZzCF6j/YurWpIaPJeE8xIh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876487; c=relaxed/simple;
	bh=EhMuN0uAJvnOsTn0xJ6V7AMhb6rZ0tcOzwTCMmNF3EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikjPW3MFvMLWrnslNhWER2m4SFA0qlq/zZugMRlDcZ1LbioROYONPkbG7CsA5XSgmcro5aLWMAtZK3zud6wb2K3ZitwxQHvHeJeH0/hZbYX1aHHgc8KqP+R+vJ70Im3Ikil4iYEyOvyhKmtVWSSe5hF4s32BGPYW8zNAtf2vEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2qBpJgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2qBpJgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E7FC4CEF7;
	Mon, 30 Mar 2026 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774876487;
	bh=EhMuN0uAJvnOsTn0xJ6V7AMhb6rZ0tcOzwTCMmNF3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2qBpJghmzSdbYDhiuzjlaeeXFYgUSaB/EaqI5PXiP8matUukTPsBT2PIlguS1U0w
	 dc/Rlqy/4YYSkKbO1a3sf7LZUscOTcJcNWKSMnEnV42ZRgEIlayUNxtNgVv/me0XMf
	 Ci7m8nEHiW4/+kUPyZBtLLY2fTNbIMIWbsmRVYUl81uTCeDaSu9uUV6juPDfnBDOVA
	 ZOYlfUKP29EjtuGui7eH6e5o2mfH4bpQwwMtv4rQf03zJKwxf3+t7oztifWUs6XshZ
	 fU828m00cLoK54qsk3h9C09RxCyYwtIrXaEUAZ8luBFTs/ijEphRMTC/QokW68VsPr
	 yCeXnB9lKpPCg==
From: Lucas De Marchi <demarchi@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Lucas De Marchi <demarchi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Phil Sutter <phil@nwl.cc>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH v2 2/2] module: Simplify warning on positive returns from module_init()
Date: Mon, 30 Mar 2026 08:13:52 -0500
Message-ID: <-v2-2-a3542e15111c@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <-v2-0-a3542e15111c@kernel.org>
References: <-v2-0-a3542e15111c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=demarchi@kernel.org; h=from:subject:message-id; bh=EhMuN0uAJvnOsTn0xJ6V7AMhb6rZ0tcOzwTCMmNF3EY=; b=owEBbQKS/ZANAwAKAZuipaYwy+pTAcsmYgBpynbgMDTJ8X7mUQqurmgBrGn4zLieP0RU9l1Ta I07Ic6j5GqJAjMEAAEKAB0WIQTqszyWkAE8czkWrIOboqWmMMvqUwUCacp24AAKCRCboqWmMMvq UxT6D/0cHtT4l6vRNJZfvyzEQ8Xh9e8T1n3KmbX1lEHZ3xRk0Q+5ceOlEbuhLMHaIRkgTYrACDG p5XdU+/ttyNkOZoBBUQ+LDjZFfMf0hxygVPDek6xbuFsoozCn+/S4SWyed8DJYgoVhMurw9DlHc rAYwqkTjWSgc+P/i+yg4DgAKPXpO/Bm3wm2o4icJs9BcV0/hfWHRPrwJeXQMt1pyrOObLhJrMH0 +/MOC3InaLSW+VhaJ2NCM2z3TGRZhbiBLck4k7mzZvRQiFpXzWt77h4woslBcHirWRrT4XIcYPK GPA1vpHRTdZ+Bad1E1zE/+UcN4szFp5zkwGYzk66RxsdriuNKZD1Sxc9Ve8X3vJks0YpEjWlL8K NeZuyW98oxHCRcchhA+9Q/WLQTZORe3PWTQwZrPReM8Ze43D0h3Y8DA6QdQtlbciyrlix5yZe4T 534FW6FI18LBiSEUIn9g/WyjeRUKfN88yVmo0oKs4FBfeGMwVRI1a7Xrgl4kJ79JdGnFrfmmKfF vsGNlLfKFdx+SRrSpVJdUHEluE3G1j3iTJXcpXlYHJAEIPih55ctwRbJyiI2ldvBLudQQLAvIYX JLVZoT3owQ6t4Q07Kv7iN0/MGnbcEMfpPBh0moTfLS0507Zw8e6Om/yvZVoWeSoBTb0DR3zUsnx j8+OiBbcpiHYkrA==
X-Developer-Key: i=demarchi@kernel.org; a=openpgp; fpr=EAB33C9690013C733916AC839BA2A5A630CBEA53
Content-Transfer-Encoding: 8bit

It should now be rare to trigger this warning - it doesn't need to be so
verbose. Make it follow the usual style in the module loading code.

For the same reason, drop the dump_stack().

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Lucas De Marchi <demarchi@kernel.org>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3b60b7cda329..5aeb5af584b4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3055,13 +3055,9 @@ static noinline int do_init_module(struct module *mod)
 
 		goto fail_free_freeinit;
 	}
-	if (ret > 0) {
-		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
-			"follow 0/-E convention\n"
-			"%s: loading module anyway...\n",
-			__func__, mod->name, ret, __func__);
-		dump_stack();
-	}
+	if (ret > 0)
+		pr_warn("%s: init suspiciously returned %d, it should follow 0/-E convention\n",
+			mod->name, ret);
 
 	/* Now it's a first class citizen! */
 	mod->state = MODULE_STATE_LIVE;

-- 
2.53.0

