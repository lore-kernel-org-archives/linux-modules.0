Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D22C029D
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435009; cv=none; b=ebH3p3CpTJEg6ms1KVrsTIYuIbu6RKVn3cnyGkK6JIS/getqqoXPECpwGeo4yswfEGTH05kfcGX4lEnHPWFfunyMjnRMGX9KmRo9WgWME2Win/WGb8/aaD8GnDcir+CceKCVGMeUbmykiNtJJekQmD/aHzcFRQrn1vwQCQ0OLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435009; c=relaxed/simple;
	bh=TgALC2rETqdRID+pkVZ3moFOvyQj7BOYE/+0B+AL6kw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7EkT+wfmqUZWS06UXJ1fHH3I+LQU1skyaZjaTt55xzVXG3tAvbek6xXozc+juJg086pIgHdprlcZEk2FbzNrD2lOp/12bEKk1Jp/8gMcZo0iIYOjNAksAyxOLyjRIzRuYOYmRBZ7uP/1u7gmP1svFmsM6zQai0M89Ie+HPtGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BV2/lXgT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BV2/lXgT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c0bead25feeso3604698a12.0
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435008; x=1767039808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASWpNTwBQuCdo4Bwu34lMAvpfkAKdg7xVWJ2XGl5NSU=;
        b=BV2/lXgT2DpBW4ovAQOdyZ5piM0H4sJdB4QtlA07QOUmwjSdYFz50JNSKOuc+nZ9u2
         m+TmisexwUXyb9JsJWW17Qd2dmKRgJ6RhKQwdJMnFTOfvxyPKd9czbv9RvmReigFIWlG
         9UPWwOyuuKOO4MI516IjOF+ZNHeLrFlpmKMRU1H0QOkkA8MuvtqlV6uQVYF5GQlTAJLZ
         h5Sf9sKjmjjIhZToxnTQ7s39eN9TKEwstDfVK2mRdYzSxTL90i8tLjP8qaC1dF31wt8h
         t/hS6YOqBVE+rpNeRxH8A63V6AwO3qE0bzerfLqZMODqjizsL3mz+jX2fl6LMvs+NihW
         K/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435008; x=1767039808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASWpNTwBQuCdo4Bwu34lMAvpfkAKdg7xVWJ2XGl5NSU=;
        b=hvuGSdJYT9acx6dd2UGuwbHiXUw/Iz1ibrhkF5RmRx5NH4niOWYfBhmLf5jTUPXsgv
         AbZsz4xRHgvqYESWzOSyl5gvi8Ly9NeD7QY5Nt6TMTGlaQLD6ONlw/p7g2VWPxUCIdVq
         8yU43zC4apei0iXNLfgUOlV48Wc6s8+Qn3b8bdttXZnrgnY2ppJG7ny4GsVcDGratF0m
         G51vP2TYrVDU/TUwIVfppqfFetEQGmmwLaiAa9E7L+cTyGbO3BFwRVvo3UItmn6y+59T
         Ut1V8/Ph0/E+SN38feuVb/bNRRVaAtrDiysxl1VPuNal4CftVWOK0RlijR4dZ8Ft5Gqo
         wolg==
X-Forwarded-Encrypted: i=1; AJvYcCWTRO1yp+v0exO0iq85N19596E2bbq3sD3HEbszMBRR0YWI4E7hSa3tjVUp8kwJGH64bx/kWFilPDIxS1SE@vger.kernel.org
X-Gm-Message-State: AOJu0YxwV3dDEjU6skar81jnVMxejBe501IZL9ph24ADFqKHYLYJpIZL
	YyOUDu8OtSMKNXWAbC8ybwWFrxBd+tzLX5nkqd6jKN7Ybo5aIfO5fgIiH8Gz+oABYeZEpsm5rxx
	hPCQ/w5b5FutdBbK+zi8ki3LHKkvUUQ==
X-Google-Smtp-Source: AGHT+IFfQTXGynsxLsLXcIwmf8TPpCDPFMb7COMuoPWOHZdZi3ombvgiQCoXqZPW38/NW4yUK/3p6LRNGK1bmMuP4RY=
X-Received: from dybdb9.prod.google.com ([2002:a05:7300:b089:b0:2ab:9468:d9cf])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:7817:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b05ec7459fmr8431184eec.27.1766435007566;
 Mon, 22 Dec 2025 12:23:27 -0800 (PST)
Date: Mon, 22 Dec 2025 20:23:16 +0000
In-Reply-To: <20251215215545.1332626-2-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251215215545.1332626-2-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=533; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=TgALC2rETqdRID+pkVZ3moFOvyQj7BOYE/+0B+AL6kw=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeK7YJZ21kMdmy0vT/XI+SpnsB/R36seHGT2SsDm3Z8
 1ZN0jSmo5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEzkjzojw5SajzumW52KMbe7
 p7JtrVJEafen6vXthzOX2zcobzm6goWRYfZ0lQ6WX7PV5h+pePyNVbNRMOrD7akZ//dOnswzTVt 7Cz8A
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400569.1902051.6640733247715892263.b4-ty@google.com>
Subject: Re: [PATCH] MAINTAINERS: Update module subsystem maintainers and repository
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 15 Dec 2025 21:55:46 +0000, Sami Tolvanen wrote:
> Add myself as a maintainer for module support as I'll be handling pull
> requests for the next six months according to the previously announced
> rotation [1][2].  Also, update the git repository link to point to the
> modules tree, which is already used by linux-next.
> 
> 

Applied to modules-next, thanks!

[1/1] MAINTAINERS: Update module subsystem maintainers and repository
      commit: d8275cdaf20e5262141dcd12b214cf035d07ed9d

Best regards,

	Sami

