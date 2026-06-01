Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529D376A11
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315506; cv=none; b=lNjt+Ful3Pq2qcYhJN1E9ovN6yYflv9MJ4yB20GF0M9vmS7q7Qe9S+NIQaDwYKN+1lAiUiWdMX3NF7VMAFkaa5T93IBuY1O41lZhMuCrzAzIxtrZwyqEYZagA4ZDFQlE3u/ssHnL2HkrveQ0N72MSRNgR+xQfnwiAluHmXudCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315506; c=relaxed/simple;
	bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKmyK26jXVmtcNBDoptqCb44zqKXUs2I2XgCtSmBULz0bfsqA+5B4kMjq88gR0kpQpUISqfRd/o8nWuyEGt/FnKeGdCACD5uws5TiwYjCxoK+2IMI9mK+WzFChSUzoidz9ivtHewIymQdK6QgNMK/RBjPj4EYfns9f+23RtpwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug+D/UHg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug+D/UHg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49050bfe053so68927275e9.3
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315504; x=1780920304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=Ug+D/UHgDkpae6UeG1SlmhwEpptQyKc7cGeIbceB0m0EM20CEYKERTMtsSMTn6gbSK
         RaLM4pUqtgz+45b5FVndHeinOjGur13/IwJGzak8WCKzpTM8a+uoTUPUXp8FHjT4ceho
         87k2d+BgD2AaniUye1LTsdwCFjTwHkg1uJ1Y5RbP/tZoSqsT5VAzmrvH0XMuAm6hAoXO
         tYboE7CnCp+379XMUSg1+7sQewsHRaMNgsbS5xCuK1LQ6uBd2fEmhm3wJPgD05hZmRI/
         DaquwYy0MbVz9Kkvh+L9pueOXvVVQ2QDYP3bccsMyrLMenCy967HxbUn3JPH5Et9rgYv
         OpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315504; x=1780920304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=Axm89fHdKTRQtGbgRRe2uk9BoZNy+1vB1hYThJhcHVcZVNjn2OVm9hALqgOn848aXf
         1nd2jl3CONHeZWEilCkZSnIhsrenc5fuONJ5Y/8IElNM20dEzT8IrVwLhK1t0x/HMyGi
         5HG53hVxhJZB6XA0MLZipgopCHCfZTaSp6StmGtGl9B45X/p2SFGvm+GeUJKIE4fCfyk
         00iX4tePfDDU57tuX0rGIiTrm3lFKivizyY5SrP+CDdk5iqi/qXqYpO4mN2pH2Gz1Yl7
         Drpkz4u7JdhK6jQojE4R8Z8vLa2cquCuXTUeR8dDkYdoMBpE+QS0HEyFbEWOezvsKANb
         tDNw==
X-Forwarded-Encrypted: i=1; AFNElJ+NE1Pum1PhH1RKRI6DB8cZfLr2FbIbadQD7xNdKdC8BHOmSVkQMKQrZcaviNefuJl1xyipFgLROztyG1uT@vger.kernel.org
X-Gm-Message-State: AOJu0YwenRVtCrcN0aHnTFw8ouxI3GiTjfMQ0PrI9Uky8u6QYJi0o4LZ
	A63lG5zXr+CS5ge6WvefgvQ7IGZCDT0MWp2MRk/MPgEOBCKxtDzbCNUN
X-Gm-Gg: Acq92OGE5vFwIVVGlE3f8HBV9FZk/2GT1TfAObKe2qZ9XzTSA3uIbsifgKgtAhfRyLD
	wdgse1HG/Lmn6Rbs6lDdIfLTeFgLQD54JXm7/oukXDohmzVIINKmEk3hAP1YI9CuuIa+oHqcMvn
	gUgbQ7VJRwLF9fgkqGgMxuWW1vsHeHQL99D+tsFGzH4xk5KwcI7HroBrHF6FBhOzBetxbshuOq+
	hQW0fejJnFYC2GEExMhkXQFI6bfx7834lMCTTAz4kfTcQdwymSVM+/cWwbXklJ1Q2czhZiDLvxp
	mkO1nNf02neAWubZwS4V06pojB1G3HfS5vDYpXIJ/023UD34FmbDAAKrkJ5haXj6sDukOhgONFv
	fC/4NYCHMwm66MMG5UsndH6B0hCXaDEe8DA6+39Wb5vD8NdcdWIkUKtsKQEVMsks9D+THXJRHYi
	ApIN+kBvsgcul7FiRgNptBkAETxEQWp+Wsxgq7kWmY9g==
X-Received: by 2002:a05:600c:1546:b0:490:50e4:7224 with SMTP id 5b1f17b1804b1-490a290bdf1mr200424025e9.3.1780315503641;
        Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:48 +0000
Subject: [PATCH v3 02/24] docs/dyndbg: explain flags parse 1st
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-2-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1814;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
 b=77QENcw7TwO5sbOCSCb3za5Eh6W1VtMb7ffsLgiJ6qjsY20R6qLFWJ9u0VHPdNWz7TZVh1MSu
 fXZPCPflAUnCuxlFjQ2BltAWo25IThXGyLGV8vp/+SKUfZSM2Av2QvG
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |

-- 
2.54.0

