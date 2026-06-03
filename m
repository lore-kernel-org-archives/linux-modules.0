Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A463EA95C
	for <linux-modules@vger.kernel.org>; Wed,  3 Jun 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503931; cv=none; b=YZkKYaNH7KhjujH6iAbsl/ciRQG4zwiQhq9iFQ6hvZR1tc3LPUsXdbmVcJIEn0bRMAsB7T+DTWyE6yCS+W3SpafP4GksDHWkNXZPOOOGQ7T++VfYO7KJQPC3j+Go0ZjS1EEKPCkqnuegklAE6u8k54drVlPTfXivAyjO4JZrW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503931; c=relaxed/simple;
	bh=YujDDyuGrciDS0gWHtUWpXqnP5DMsYmaDFfvtq1vBWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qlgC/6UXPHD0tDmzYi0TsAiSdZhaI4UkcOijCEFbAGh//otW+KFYN4SL+6xJlJ+9SINLpjzdYLpC9r7Ia124oOmPtBK8VQQktevwSyF1Z3xqySNsLUgOc/GU66toe9Wt2bZbSOU+12P5ZpB3IH1X/s7AXll9zWoxaw02EP+zMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQRSbvA0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQRSbvA0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf36a6905cso33083845ad.3
        for <linux-modules@vger.kernel.org>; Wed, 03 Jun 2026 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503929; x=1781108729; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXTwm/dv/FFCf2h8WWpinsWjPQ3nXBBRBwX5/F3AfLc=;
        b=ZQRSbvA0irX+i1RSe+gIq2CkH91x/7kjGi8N36CMO7IqTqa7jCTal2bdHSoNblYpJz
         pKTQ+Q4EoeC1HiulZ3rZ5mD6Z70yworUSJ7yg/idmqg7Ctk66UU8FyjS1IE74oNnLL9D
         hBjWCvb4KCvaVlVqNmq8571ZazvfSeTT88XbLdJAOx8+Ry2XBcCo3efW+4gbpbzKLOSx
         4XZJEkagsXwy31pqeZ1o0EWAdvsWbbrx372ce3AlLFn8jDJmE99eu8KJ229We7eTM41Y
         4zRUvWg/U5DWE8sN7cNdWzvsTj7xppva6ts+qTmIMTKkZna2pZMKkDy1tFkYsnxNOwEp
         cFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503929; x=1781108729;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXTwm/dv/FFCf2h8WWpinsWjPQ3nXBBRBwX5/F3AfLc=;
        b=WC6hvmBN7Em/1fqGrgpk/ulvA8Pj/koC0Wr+DrKdNGFNvfi2sjcOs8ajy4mFdLBxyB
         ZAMSmStYGqUmAxA0USdlwBWSqAQSS5yeNKHAK5v0Hs16Mrbt9XjV/FkhWeVYJnvOu9uZ
         a6NnhNn9A/ufW03XZ06wT7fGjYp9B3kF/EJv7Nmcher7K+d0fej1ye1o9Hn3AnCNj1+n
         8Hjt/ar9NQ3ivSnnY2Q73QNIdpDDN0yQHuzOkbUozDitHbjXU8Y4qADVWjc4zO7nGbFx
         j0bh0ni6Q7vYDgIWQs8lFh83U/7DtiQCaQnGTXIdYWS0bWdmCq7FSgcFl1z54najuV43
         N1hA==
X-Forwarded-Encrypted: i=1; AFNElJ+2HKxf/COZYHdYaJD6Nroo4jt2DWddqE2UefKGn+9w8qLw2uWbEnDbslxSdhwLxjs06EczsSWV1poA1VIr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJoTcmZzK9hOB7j36JHhmFekkpOa3efVHoiVuXc+0YA3aY4lQ
	Dv1jPPCtydQFK7/HFek0x7rHmXM7XAx4f9l19cbsMF8a/m5zdi6zZjgE
X-Gm-Gg: Acq92OGLbqjUNuxn5D6Ma2n8oCaM0e4r8odWHoqDKKIRm8In8F81tzH9ld6dcYSvspP
	Qs6rH7O41ecCqjaGRFvQq9ubyRhSdov0zsc+P/MF9obtlx3wl+FqKY8cCDfxeH+fsiVJN1YLWsv
	/HwqbanCs/Dr+WIgLQdItasxcJn96CdWZNAuwbZweOSL2KpSOBEkDSDnfcUJX9xOitljdn+S8Gz
	sAbZGbq2XPwL4wGbBWDCpSnTQ9di9+ZHF/KKAUU8PBU/GX5L8CIex4fBJksffxrL59n/WNmf1UH
	7lLkBM3Zaic7BTiB10e8zsMKdA2pT3gQml5gT0WtNaG+aJIzolTAZF10bU8/r/tul2S7mCkuUdo
	Vv1xkTxLb6jiUUSN/aSP7c2r6xW6sW2BjcRzYjFpx2ck65t86y8PBARupfGSQxhgDk3SKN2r4lZ
	/VY2YfB7yBOuLVUhOUZFLP5FtTRKbWxBH4LnaE4/DpcZy2pw==
X-Received: by 2002:a17:902:d58c:b0:2c0:ccdb:e02c with SMTP id d9443c01a7336-2c163a1d814mr48649235ad.7.1780503929003;
        Wed, 03 Jun 2026 09:25:29 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ae328sm29323695ad.84.2026.06.03.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:25:28 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:55:26 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com
Cc: atomlin@atomlin.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: dups: use strscpy() to copy module name in dup
 request
Message-ID: <v546667lngoo6dxwb7gqzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

kmod_dup_request_exists_wait() uses memcpy() with strlen(module_name) to
copy into new_kmod_req->name, a fixed-size char[MODULE_NAME_LEN] buffer.
This does not bounds-check the copy and does not explicitly NUL-terminate.
The buffer is zeroed from kzalloc_obj() so NUL-termination happens to
work, but the pattern is fragile and lacks an explicit bounds check.

Replace with strscpy() which bounds the copy and guarantees
NUL-termination.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 kernel/module/dups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 1d720a5311ba..33bddfb57317 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -129,7 +129,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	if (!new_kmod_req)
 		return false;
 
-	memcpy(new_kmod_req->name, module_name, strlen(module_name));
+	strscpy(new_kmod_req->name, module_name, MODULE_NAME_LEN);
 	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
-- 
2.43.0

