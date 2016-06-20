MIME-Version: 1.0
In-Reply-To: <5767ECB7.8040203@suse.com>
References: <1466172255-20955-1-git-send-email-mmarek@suse.com>
	<CAKi4VA+DD1gO61s1y46tetDkQAbRDUhhhUGYUM_0Nc6PiP5LEQ@mail.gmail.com>
	<5767ECB7.8040203@suse.com>
Date: Mon, 20 Jun 2016 10:41:18 -0300
Message-ID: <CAKi4VAJXUrovNoHCZzarZE1Udm6Rz-CePGOO9YyrfsN+Ag30rw@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Handle long lines in /proc/modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jun 20, 2016 at 10:16 AM, Michal Marek <mmarek@suse.com> wrote:
> On 2016-06-20 14:55, Lucas De Marchi wrote:
>> On Fri, Jun 17, 2016 at 11:04 AM, Michal Marek <mmarek@suse.com> wrote:
>>> Also, the buffer could be shrinked now, so that we do not use that much
>>> space on stack. Not sure if this is of interest or not. I left it as is.
>>
>> Yep, I think it's reasonable to be 64 bytes since it's the maximum
>> length of a module name
>
> OK. In kmod_module_get_size(), the buffer needs to be larger, though.
>
>
>>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>>> index 1460c6746cc4..25dcda7667b7 100644
>>> --- a/libkmod/libkmod-module.c
>>> +++ b/libkmod/libkmod-module.c
>>> @@ -1660,13 +1660,14 @@ KMOD_EXPORT int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
>>>                 struct kmod_module *m;
>>>                 struct kmod_list *node;
>>>                 int err;
>>> +               size_t len = strlen(line);
>>>                 char *saveptr, *name = strtok_r(line, " \t", &saveptr);
>>>
>>>                 err = kmod_module_new_from_name(ctx, name, &m);
>>>                 if (err < 0) {
>>>                         ERR(ctx, "could not get module from name '%s': %s\n",
>>>                                 name, strerror(-err));
>>> -                       continue;
>>> +                       goto eat_line;
>>
>> I think it would be better to "eat line" before anything else, above
>> kmod_module_new_from_name(). So you don't need to change the flow
>> here.
>
> Sure, but then we would need two buffers, because name is a pointer into
> line.

oh, right. Thinking again, I'm ok with your version.

Lucas De Marchi
