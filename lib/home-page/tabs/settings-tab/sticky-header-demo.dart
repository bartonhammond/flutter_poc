import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class StickyHeaderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
      slivers: _buildSlivers(context),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();

    int i = 0;
    slivers.addAll(_buildLists(context, i, i += 3));
    slivers.addAll(_buildGrids(context, i, i += 3));
    slivers.addAll(_buildSideHeaderGrids(context, i, i += 3));
    slivers.addAll(_buildHeaderBuilderLists(context, i, i += 5));
    return slivers;
  }

  List<Widget> _buildLists(BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => new ListTile(
                  leading: new CircleAvatar(
                    child: new Text('$sliverIndex'),
                  ),
                  title: Container(
                    child: Row(
                      children: <Widget>[
                        new Text('List $i'),
                        Expanded(
                          child: new TextField(),
                        )
                      ],
                    ),
                  ),
                ),
            childCount: 4,
          ),
        ),
      );
    });
  }

  List<Widget> _buildHeaderBuilderLists(
      BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeaderBuilder(
        builder: (context, state) =>
            _buildAnimatedHeader(context, sliverIndex, state),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => new ListTile(
                  leading: new CircleAvatar(
                    child: new Text('$sliverIndex'),
                  ),
                  title: new Text('List tile #$i'),
                ),
            childCount: 4,
          ),
        ),
      );
    });
  }

  List<Widget> _buildGrids(BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverGrid(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          delegate: new SliverChildBuilderDelegate(
            (context, i) => GestureDetector(
                  onTap: () => Scaffold.of(context).showSnackBar(
                      new SnackBar(content: Text('Grid tile #$i'))),
                  child: new GridTile(
                    child: Card(
                      child: new Container(
                        color: Colors.green,
                      ),
                    ),
                    footer: new Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          'Grid tile #$i',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
            childCount: 9,
          ),
        ),
      );
    });
  }

  List<Widget> _buildSideHeaderGrids(
      BuildContext context, int firstIndex, int count) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        overlapsContent: true,
        header: _buildSideHeader(context, sliverIndex),
        sliver: new SliverPadding(
          padding: new EdgeInsets.only(left: 60.0),
          sliver: new SliverGrid(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 1.0),
            delegate: new SliverChildBuilderDelegate(
              (context, i) => GestureDetector(
                    onTap: () => Scaffold.of(context).showSnackBar(
                        new SnackBar(content: Text('Grid tile #$i'))),
                    child: new GridTile(
                      child: Card(
                        child: new Container(
                          color: Colors.orange,
                        ),
                      ),
                      footer: new Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            'Grid tile #$i',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
              childCount: 12,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(int index, {String text}) {
    return new Container(
      height: 60.0,
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        text ?? 'Header #$index',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSideHeader(BuildContext context, int index, {String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: new SizedBox(
          height: 44.0,
          width: 44.0,
          child: GestureDetector(
            onTap: () => Scaffold.of(context)
                .showSnackBar(new SnackBar(content: Text('$index'))),
            child: new CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
              child: new Text('$index'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(
      BuildContext context, int index, SliverStickyHeaderState state) {
    return GestureDetector(
      onTap: () => Scaffold.of(context)
          .showSnackBar(new SnackBar(content: Text('$index'))),
      child: new Container(
        height: 60.0,
        color: (state.isPinned ? Colors.indigo : Colors.lightBlue)
            .withOpacity(1.0 - state.scrollPercentage),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: new Text(
          'Header #$index',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
