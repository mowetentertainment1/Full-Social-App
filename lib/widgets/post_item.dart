import 'package:flutter/material.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import '../models/post_model.dart';
import '../shared/styles/color.dart';

class PostItem extends StatelessWidget {
  // const PostItem({Key? key}) : super(key: key);
  final PostModel model;

  final int? postIndex;

  PostItem({required this.model, this.postIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    model.userProfileImage!,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(model.username!),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.check_circle,
                          size: 18,
                        ),
                      ],
                    ),
                    Text(
                      model.dateTime!,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                      size: 18,
                    ))
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Text(
              model.postText!,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    height: 1.35,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 8.0),
            // Wrap(
            //   children: [
            //     profileTag(text: '#software_development'),
            //     // profileTag(text: '#mobile_development'),
            //     // profileTag(text: '#flutter_development'),
            //     profileTag(text: '#agile_development'),
            //     profileTag(text: '#IT'),
            //   ],
            // ),
            const SizedBox(height: 8),
            if (model.postImage! != '')
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  model.postImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 210,
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          //Text('${SocialCubit.get(context).numberOfLikes[postIndex!]}'),
                          Text('1200'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.message,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '120 Comment',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModelData!.image!}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'write a comment ... ',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context).setPostsLikes(
                        SocialCubit.get(context).postsId[postIndex!]);
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileTag({required String text}) => Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        text,
        style: const TextStyle(
            color: AppColor.mainColor, fontSize: 14, height: 1.4),
      ),
    );
